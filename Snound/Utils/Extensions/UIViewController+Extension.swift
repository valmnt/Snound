//
//  UIViewController+Extension.swift
//  Snound
//
//  Created by Valentin Mont on 11/10/2023.
//

import UIKit

extension UIViewController {
    func layoutTrait(traitCollection:UITraitCollection,
                     sharedConstraints: [NSLayoutConstraint],
                     regularConstraints: [NSLayoutConstraint],
                     compactConstraints: [NSLayoutConstraint],
                     compactCallback: (() -> Void),
                     regularCallback: (() -> Void)) {
        if (!sharedConstraints[0].isActive) {
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
            compactCallback()
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
            regularCallback()
        }
    }
}
