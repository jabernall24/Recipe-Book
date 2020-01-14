//
//  Alert.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/14/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okayAction)
            vc.present(alert, animated: true)
        }
    }
    
    static func showPasswordsDoNotMatchAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Passwords do not match", message: "Check that the passwords match and try again")
    }
    
    static func showRBErrorAlert(on vc: UIViewController, with error: RBError) {
        showBasicAlert(on: vc, with: "Whoops, somethig went wrong", message: error.rawValue)
    }
}
