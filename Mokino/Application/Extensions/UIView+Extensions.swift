//
//  UIView+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

extension UIView {
    
    func setDefaultCornerRadius() {
        layer.cornerRadius = 12.0
        layer.masksToBounds = true
    }
}
