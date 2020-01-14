//
//  LogInVC.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

final class LogInVC: UIViewController {

    private let emailView = RBLoginTextField(placeholder: "Email not required", title: "Email")
    private let usernameOrEmailView = RBLoginTextField(placeholder: "Enter your email or username", title: "Email or Username")
    private let passwordView = RBLoginTextField(placeholder: "Enter your password", title: "Password")
    private let confirmPasswordView = RBLoginTextField(placeholder: "Confirm password", title: "Confirm password")
    
    private let signInButton = RBButton(title: "Sign In", backgroundColor: .systemPurple)
    private var signInButtonActiveWidthAnchor: NSLayoutConstraint!
    private var signInButtonInactiveWidthAnchor: NSLayoutConstraint!
    
    private let signUpButton = RBButton(title: "Sign Up", backgroundColor: .systemPurple)
    private var signUpButtonActiveWidthAnchor: NSLayoutConstraint!
    private var signUpButtonInactiveWidthAnchor: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configurePasswordView()
        configureConfirmPasswordView()
        configureUsernameEmailView()
        confireSignInButton()
        configureEmailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Sign In"
    }
    
    @objc private func onSignUp() {
        animateTextFieldsBackToNormal()
        view.endEditing(true)
        
        if !confirmPasswordView.isHidden {
            signUp()
            return
        }
        
        signUpButton.layer.borderWidth = 2
        signInButton.layer.borderWidth = 0
        
        signUpButtonInactiveWidthAnchor.isActive = false
        signUpButtonActiveWidthAnchor.isActive = true
        
        signInButtonActiveWidthAnchor.isActive = false
        signInButtonInactiveWidthAnchor.isActive = true
        
        confirmPasswordView.isHidden = false
        emailView.isHidden = false
        
        usernameOrEmailView.textField.placeholder = "Enter a username"
        usernameOrEmailView.label.text = "Username"
        navigationItem.title = "Sign Up"
    }
    
    private func signUp() {
        guard passwordView.textField.text == confirmPasswordView.textField.text else {
            passwordView.textField.incorrectInput()
            confirmPasswordView.textField.incorrectInput()
            Alert.showPasswordsDoNotMatchAlert(on: self)
            return
        }
        let user = User()
        user?._email = emailView.textField.text
        user?._username = usernameOrEmailView.textField.text
        user?._password = passwordView.textField.text

        UserDbManager.shared.create(user!) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                switch error {
                case .emailExists, .emailInvalid:
                    self.emailView.textField.incorrectInput()
                case .usernameExists, .usernameInvalid, .usernameNotDefined:
                    self.usernameOrEmailView.textField.incorrectInput()
                default:
                    break
                }
                Alert.showRBErrorAlert(on: self, with: error)
            }
        }
    }
    
    @objc private func onSignIn() {
        animateTextFieldsBackToNormal()
        view.endEditing(true)
        
        if confirmPasswordView.isHidden {
            signIn()
            return
        }
        
        signUpButton.layer.borderWidth = 0
        signInButton.layer.borderWidth = 2
        
        signUpButtonActiveWidthAnchor.isActive = false
        signUpButtonInactiveWidthAnchor.isActive = true
        
        signInButtonInactiveWidthAnchor.isActive = false
        signInButtonActiveWidthAnchor.isActive = true
        
        confirmPasswordView.isHidden = true
        emailView.isHidden = true
        
        usernameOrEmailView.textField.placeholder = "Enter your email or username"
        usernameOrEmailView.label.text = "Email or Username"
        navigationItem.title = "Sign In"
    }
    
    private func signIn() {

    }
    
    private func handleConfirmPasswordReturn() {
        if usernameOrEmailView.textField.text!.isEmpty || passwordView.textField.text!.isEmpty {
            view.endEditing(true)
        } else {
            onSignIn()
        }
    }
}

extension LogInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailView.textField:
            usernameOrEmailView.textField.becomeFirstResponder()
        case usernameOrEmailView.textField:
            passwordView.textField.becomeFirstResponder()
        case passwordView.textField:
            if confirmPasswordView.isHidden {
                onSignIn()
            } else {
                confirmPasswordView.textField.becomeFirstResponder()
            }
        case confirmPasswordView.textField:
            onSignUp()
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextFieldsAboveKeyboard()
    }
    
    func animateTextFieldsAboveKeyboard() {
        UIView.animate(withDuration: 0.5) {
            self.emailView.transform = CGAffineTransform(translationX: 0, y: -100)
            self.usernameOrEmailView.transform = CGAffineTransform(translationX: 0, y: -100)
            self.passwordView.transform = CGAffineTransform(translationX: 0, y: -100)
            self.confirmPasswordView.transform = CGAffineTransform(translationX: 0, y: -100)
        }
    }
    
    func animateTextFieldsBackToNormal() {
        UIView.animate(withDuration: 0.5) {
            self.emailView.transform = .identity
            self.usernameOrEmailView.transform = .identity
            self.passwordView.transform = .identity
            self.confirmPasswordView.transform = .identity
        }
    }
}

extension LogInVC {
    
    private func configurePasswordView() {
        view.addSubview(passwordView)
        passwordView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        passwordView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        passwordView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        passwordView.textField.delegate = self
        passwordView.textField.isSecureTextEntry = true
    }
    
    private func configureConfirmPasswordView() {
        view.addSubview(confirmPasswordView)
        confirmPasswordView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -8).isActive = true
        confirmPasswordView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        confirmPasswordView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        confirmPasswordView.textField.delegate = self
        confirmPasswordView.textField.returnKeyType = .default
        confirmPasswordView.textField.isSecureTextEntry = true
        confirmPasswordView.isHidden = true
    }
    
    private func configureUsernameEmailView() {
        view.addSubview(usernameOrEmailView)
        usernameOrEmailView.bottomAnchor.constraint(equalTo: passwordView.topAnchor, constant: 8).isActive = true
        usernameOrEmailView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        usernameOrEmailView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        usernameOrEmailView.textField.delegate = self
    }
    
    private func configureEmailView() {
        view.addSubview(emailView)
        emailView.bottomAnchor.constraint(equalTo: usernameOrEmailView.topAnchor, constant: 8).isActive = true
        emailView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emailView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9).isActive = true
        emailView.textField.delegate = self
        emailView.textField.keyboardType = .emailAddress
        emailView.isHidden = true
    }
    
    private func confireSignInButton() {
        view.addSubview(signInButton)

        signInButton.topAnchor.constraint(equalTo: confirmPasswordView.bottomAnchor, constant: 32).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButtonActiveWidthAnchor = signInButton.widthAnchor.constraint(equalToConstant: 250)
        signInButtonInactiveWidthAnchor = signInButton.widthAnchor.constraint(equalToConstant: 150)
        signInButtonActiveWidthAnchor.isActive = true

        signInButton.addTarget(self, action: #selector(onSignIn), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButtonInactiveWidthAnchor = signUpButton.widthAnchor.constraint(equalToConstant: 150)
        signUpButtonActiveWidthAnchor = signUpButton.widthAnchor.constraint(equalToConstant: 250)
        signUpButtonInactiveWidthAnchor.isActive = true

        signUpButton.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
        signUpButton.layer.borderWidth = 0
    }
}
