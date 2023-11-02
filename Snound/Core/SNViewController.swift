//
//  SNViewControlelr.swift
//  Snound
//
//  Created by Valentin Mont on 01/11/2023.
//

import Foundation
import SQLite
import UIKit

class SNViewController: UIViewController {
    
    var dbSQLite: Connection? {
        (UIApplication.shared.delegate as? AppDelegate)?.databaseSQLite
    }
    
    var compactConstraints: [NSLayoutConstraint] = []
    var regularConstraints: [NSLayoutConstraint] = []
    var sharedConstraints: [NSLayoutConstraint] = []
    
    var compactCallback: (() -> Void)?
    var regularCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(resource: R.color.background)
        layoutTrait(traitCollection: traitCollection,
                    sharedConstraints: sharedConstraints,
                    regularConstraints: regularConstraints,
                    compactConstraints: compactConstraints,
                    compactCallback: compactCallback ?? {},
                    regularCallback: regularCallback ?? {})
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection,
                    sharedConstraints: sharedConstraints,
                    regularConstraints: regularConstraints,
                    compactConstraints: compactConstraints,
                    compactCallback: compactCallback ?? {},
                    regularCallback: regularCallback ?? {})
    }
    
    func layoutTrait(traitCollection:UITraitCollection,
                     sharedConstraints: [NSLayoutConstraint],
                     regularConstraints: [NSLayoutConstraint],
                     compactConstraints: [NSLayoutConstraint],
                     compactCallback: (() -> Void),
                     regularCallback: (() -> Void)) {
        if (!sharedConstraints.isEmpty && !sharedConstraints[0].isActive) {
            NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if !regularConstraints.isEmpty && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
            compactCallback()
        } else {
            if !compactConstraints.isEmpty && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
            regularCallback()
        }
    }
}
