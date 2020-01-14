//
//  UIColor+Ext.swift
//  Recipe Book
//
//  Created by Jesus Andres Bernal Lopez on 1/12/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

enum AssetsColor : String {
    case textColor
}
extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue)!
    }
}
