//
//  UserDbManager.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import Foundation
import AWSDynamoDB
import BCrypt

class UserDbManager {
    static let shared = UserDbManager()
    
    private let dynamoObjectMapper = AWSDynamoDBObjectMapper.default()
    
    private init() {}
    
    func create(_ user: User, completion: @escaping(Result<User, RBError>) -> Void) {
        
        if !user._username!.isValidUsername {
            completion(.failure(.usernameInvalid))
            return
        }
        
        if !user._password!.isStrongPassword {
            completion(.failure(.weakPassword))
            return
        }
        
        
        
        isEmailTaken(email: user._email) { [weak self] result in
            guard let self = self else {
                completion(.failure(.internalServer))
                return
            }

            if user._email != nil && !user._email!.isEmpty && !user._email!.isValidEmail {
                completion(.failure(.emailInvalid))
                return
            }
            
            switch result {
            case .success(_):
                self.isUsernameTaken(username: user._username!) { result in
                    switch result {
                    case .success(_):
                        user._email = user._email != nil && !user._email!.isEmpty ? user._email!.lowercased() : nil
                        user._userId = UUID().description
                        user._dateCreated = Date().toString()
                        user._code = String(Int.random(in: 10000..<99999))
                        user._verified = false
                        do { user._password = try self.hash(password: user._password!)
                        } catch {
                            completion(.failure(.signUp))
                            return
                        }
                        
                        self.dynamoObjectMapper.save(user) { error in
                            if let error = error {
                                print("Save user: \(error)")
                                completion(.failure(.signUp))
                                return
                            }
                            completion(.success(user))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func isEmailTaken(email: String?, completionHandler: @escaping(Result<Void, RBError>) -> Void) {
        guard let email = email, !email.isEmpty else {
            completionHandler(.success(()))
            return
        }
        let query = AWSDynamoDBQueryExpression()

        query.indexName = "GetUserByEmail"
        query.keyConditionExpression = "#email = :email"
        query.expressionAttributeNames = [ "#email": "email" ]
        query.expressionAttributeValues = [ ":email": email ]
        query.projectionExpression = "email"

        dynamoObjectMapper.query(User.self, expression: query) { output, error in
            if let error = error {
                print("Query email: \(error)")
                completionHandler(.failure(.signUp))
                return
            }

            if output != nil && output!.items.count == 1 {
                completionHandler(.failure(.emailExists))
                return
            }
            
            completionHandler(.success(()))
        }
    }
    
    private func isUsernameTaken(username: String, completionHandler: @escaping(Result<Void, RBError>) -> Void) {
        let query = AWSDynamoDBQueryExpression()

        query.indexName = "GetUserByUsername"
        query.keyConditionExpression = "#username = :username"
        query.expressionAttributeNames = [ "#username": "username" ]
        query.expressionAttributeValues = [ ":username": username ]
        query.projectionExpression = "username"
        
        dynamoObjectMapper.query(User.self, expression: query) { output, error in
            if let error = error {
                print("Query username: \(error)")
                completionHandler(.failure(.signUp))
                return
            }

            if output != nil && output!.items.count == 1 {
                completionHandler(.failure(.usernameExists))
                return
            }
            
            completionHandler(.success(()))
        }
    }
    
    private func hash(password: String) throws -> String {
        var hashedPassword = ""
        do {
            let salt = try BCrypt.Salt()
            hashedPassword = try BCrypt.Hash(password, salt: salt)
        } catch {
            throw error
        }
        return hashedPassword
    }
}
