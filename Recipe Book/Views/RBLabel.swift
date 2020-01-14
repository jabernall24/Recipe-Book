//
//  RBLabel.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

final class RBLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    convenience init() { self.init(frame: .zero) }
    
    convenience init(text: String = "", textColor: UIColor = .label) {
        self.init(frame: .zero)
        
        setUpView(text: text, textColor: textColor)
    }
    
    fileprivate func setUpView(text: String = "", textColor: UIColor = .label) {
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = textColor
        font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

