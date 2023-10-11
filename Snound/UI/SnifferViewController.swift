//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

class SnifferViewController: UIViewController {
    
    private let gradient: CAGradientLayer = CAGradientLayer()
    
    private lazy var snifferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(sniff), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.setGradientBackground(gradient: gradient,colors: [
            UIColor(resource: R.color.background)!.withAlphaComponent(0.4).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.5).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.6).cgColor,
        ])
        view.addSubview(snifferButton)
        setupConstraints()
        layoutTrait()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gradient.frame.size = size
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait()
    }
    
    @objc func sniff() {}
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            snifferButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            snifferButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        regularConstraints.append(contentsOf: [
            snifferButton.widthAnchor.constraint(equalToConstant: 300),
            snifferButton.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        compactConstraints.append(contentsOf: [
            snifferButton.widthAnchor.constraint(equalToConstant: 150),
            snifferButton.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func layoutTrait() {
        layoutTrait(traitCollection: traitCollection,
                    sharedConstraints: sharedConstraints,
                    regularConstraints: regularConstraints,
                    compactConstraints: compactConstraints,
            compactCallback: {
                responsiveSnifferButton(cornerRadius: 75, imageSize: 75)
            },
            regularCallback: {
                responsiveSnifferButton(cornerRadius: 150, imageSize: 150)
            }
        )
    }
    
    private func responsiveSnifferButton(cornerRadius: CGFloat, imageSize: CGFloat) {
        snifferButton.layer.cornerRadius = cornerRadius
        snifferButton.setImage(UIImage(resource: R.image.waveSound)?.resize(newWidth: imageSize), for: .normal)
    }
}
