//
//  UIView+Extension.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

extension UIView {
    func setGradientBackground(gradient: CAGradientLayer, colors: [CGColor]) {
        gradient.colors = colors
        gradient.frame.size = frame.size
        layer.insertSublayer(gradient, at: 0)
    }
}
