//
//  UpwardsBlurEdge.swift
//  Snound
//
//  Created by Valentin Mont on 01/11/2023.
//

import Foundation
import UIKit

class UpwardsBlurEdge: UIVisualEffectView {
    
    lazy var grad: CAGradientLayer = {
        let g = CAGradientLayer()
        g.colors = [
            UIColor.white.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        g.startPoint = CGPoint(x: 0.5, y: 1)
        g.endPoint = CGPoint(x: 0.5, y: 0)
        layer.mask = g
        return g
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        grad.frame = bounds
    }
}
