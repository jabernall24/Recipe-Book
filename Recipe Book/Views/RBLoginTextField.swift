//
//  RBLoginTextField.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/12/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

class RBLoginTextField: UIView {

    let textField = RBTextField(placeholderText: "Placeholder")
    let label = RBLabel(text: "Label", textColor: .systemGray2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTextField()
        configureLabel()
    }
    
    convenience init(placeholder: String, title: String) {
        self.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        label.text = title
    }
    
    @objc private func textFieldDidChange() {
        label.isHidden = textField.text!.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RBLoginTextField {
    
    private func configureTextField() {
        addSubview(textField)
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.returnKeyType = .next
    }
    
    private func configureLabel() {
        addSubview(label)
        label.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.isHidden = true
    }
}
