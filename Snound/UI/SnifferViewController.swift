//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

class SnifferViewController: UIViewController {
    
    lazy var backgroundColor: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(resource: R.color.background)!.withAlphaComponent(0.4).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.5).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.6).cgColor,
        ]
        return gradient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        backgroundColor.frame = view.bounds
        view.layer.insertSublayer(backgroundColor, at: 0)
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        backgroundColor.frame.size = size
        view.layer.insertSublayer(backgroundColor, at: 0)
    }
}

