//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

class SnifferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
    }
    
    func setupBackgroundColor() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(resource: R.color.background)!.withAlphaComponent(0.6).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.7).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.8).cgColor,
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }
}

