//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit

class SnifferViewController: UIViewController {
    
    private let gradient: CAGradientLayer = CAGradientLayer()
    private var animatableLayer : CAShapeLayer = CAShapeLayer()
    
    private lazy var snifferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(sniff), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to recognize"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.addSubview(mainLabel)
        setupConstraints()
        layoutTrait()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gradient.frame.size = size
        coordinator.animate(alongsideTransition: nil) { _ in
            self.animatableLayer.position = self.snifferButton.center
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        radioWaveAnimation()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait()
    }
    
    @objc func sniff() {
        startSniffButtonAnimation()
        startRadioWaveAnimation()
    }
    
    private func radioWaveAnimation() {
        animatableLayer.fillColor = CGColor(red: 144/255.0, green: 238/255.0, blue: 144/255.0, alpha: 0.5)
        animatableLayer.path = UIBezierPath(roundedRect: snifferButton.bounds, cornerRadius: snifferButton.layer.cornerRadius).cgPath
        animatableLayer.frame = snifferButton.bounds
        animatableLayer.position = snifferButton.center
        animatableLayer.cornerRadius = snifferButton.layer.cornerRadius
        animatableLayer.isHidden = true
        view.layer.addSublayer(animatableLayer)
    }
    
    private func startRadioWaveAnimation() {
        animatableLayer.isHidden = false
        let layerAnimation = CABasicAnimation(keyPath: "transform.scale")
        layerAnimation.fromValue = 1
        layerAnimation.toValue = 3
        layerAnimation.isAdditive = false

        let layerAnimation2 = CABasicAnimation(keyPath: "opacity")
        layerAnimation2.fromValue = 1
        layerAnimation2.toValue = 0
        layerAnimation2.isAdditive = false

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [layerAnimation,layerAnimation2]
        groupAnimation.duration = CFTimeInterval(2)
        groupAnimation.fillMode = CAMediaTimingFillMode.forwards
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.repeatCount = .infinity

        animatableLayer.add(groupAnimation, forKey: "growingAnimation")
    }
    
    private func startSniffButtonAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0.1, options: [], animations: {
            self.snifferButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { (finished) in
            self.snifferButton.transform = CGAffineTransform.identity
        }
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            // SnifferButton
            snifferButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            snifferButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // MainLabel
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: snifferButton.topAnchor, constant: -40),
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
                mainLabelFont(size: 25)
            },
            regularCallback: {
                responsiveSnifferButton(cornerRadius: 150, imageSize: 150)
                mainLabelFont(size: 40)
            }
        )
    }
    
    private func responsiveSnifferButton(cornerRadius: CGFloat, imageSize: CGFloat) {
        snifferButton.layer.cornerRadius = cornerRadius
        snifferButton.setImage(UIImage(resource: R.image.waveSound)?.resize(newWidth: imageSize), for: .normal)
    }
    
    private func mainLabelFont(size: CGFloat) {
        mainLabel.font = .boldSystemFont(ofSize: size)
    }
}
