//
//  RBTextField.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

final class RBTextField: UITextField {
    
    private let bottomBorderColor: UIColor = .label
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
    }
    
    convenience init(placeholderText: String) {
        self.init(frame: .zero)
        placeholder = placeholderText
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = UIColor.white.cgColor
    }
    
    fileprivate func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        textColor = .label
        setBottomBorder(color: bottomBorderColor)
        font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func incorrectInput() {
        DispatchQueue.main.async {
            self.layer.shadowColor = UIColor.red.cgColor
            
            self.shake()
            self.vibratePhone()
        }
    }
    
    func correctInput() {
        DispatchQueue.main.async { self.layer.shadowColor = self.bottomBorderColor.cgColor }
    }
    
    fileprivate func setBottomBorder(color: UIColor) {
        borderStyle = .none
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
