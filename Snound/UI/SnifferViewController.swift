//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

class SnifferViewController: UIViewController {
    
    private let gradient: CAGradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.setGradientBackground(gradient: gradient,colors: [
            UIColor(resource: R.color.background)!.withAlphaComponent(0.4).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.5).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.6).cgColor,
        ])
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gradient.frame.size = size
    }
}

