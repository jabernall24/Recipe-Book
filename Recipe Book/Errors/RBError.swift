//
//  RBError.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/12/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import Foundation

enum RBError: String, Error {
    case signUp                 = "Unable to sign you up, please try again."
    case internalServer         = "Something went wrong on our end, please try again."

    case emailExists            = "Email already exists, enter a different email or log in."
    case emailInvalid           = "Invalid email, please enter a valid email."
    
    case usernameExists         = "Username already exists, enter a different email or log in."
    case usernameNotDefined     = "Username is not defined."
    case usernameInvalid        = "Username must be 5 - 50 characters long and may only contain a-z, A-Z, 0-9 characters"
    
    case weakPassword           = "Password must be at least 8 characters long and contain at least 1 lowercase, 1 uppercase, 1 digit and 1 special character."
}
