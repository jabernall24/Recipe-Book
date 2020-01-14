//
//  User.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB

@objcMembers
class User: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    @objc var _userId: String?
    @objc var _code: String?
    @objc var _dateCreated: String?
    @objc var _email: String?
    @objc var _facebook: String?
    @objc var _instagram: String?
    @objc var _password: String?
    @objc var _twitter: String?
    @objc var _username: String?
    @objc var _verified: NSNumber?
    @objc var _youtube: String?
    
    class func dynamoDBTableName() -> String {
        return USER_TABLE_NAME
    }
    
    class func hashKeyAttribute() -> String {
        return "_userId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_userId" : "userId",
               "_code" : "code",
               "_dateCreated" : "dateCreated",
               "_email" : "email",
               "_facebook" : "facebook",
               "_instagram" : "instagram",
               "_password" : "password",
               "_twitter" : "twitter",
               "_username" : "username",
               "_verified" : "verified",
               "_youtube" : "youtube",
        ]
    }
}
