//
//  RBButton.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/11/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

final class RBButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    convenience init(image: UIImage, backgroundColor: UIColor) {
        self.init()
        
        self.setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.label.cgColor
    }
    
    @objc private func animateButton(_ sender: UIButton) {
                
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { complete in
            if complete {
                sender.transform = .identity
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RBButton {
    
    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(.label, for: .normal)
        layer.borderWidth = 2
        layer.borderColor = UIColor.label.cgColor
        layer.cornerRadius = 10
        
        addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
    }
    
}
