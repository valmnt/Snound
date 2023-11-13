//
//  SnifferViewController.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit
import ShazamKit
import AudioToolbox

protocol SnifferDelegate {
    func displayBottomSheet()
}

class SnifferViewController: SNViewController {
    
    private let viewModel: SnifferViewModel = SnifferViewModel()
    private let gradient: CAGradientLayer = CAGradientLayer()
    private let animatableLayer: CAShapeLayer = CAShapeLayer()
    private var shMusicListDelegate: SHMusicListDelegate?
    
    private lazy var snifferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.addTarget(self, action: #selector(sniff), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 50
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.sniffer.tapToRecognize.callAsFunction()
        label.textColor = UIColor(resource: R.color.primary)
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonRegularSize: CGFloat = 300
    private let buttonCompactSize: CGFloat = 150

    override func viewDidLoad() {
        compactCallback = { [weak self] in
            guard let self = self else { return }
            self.responsiveSnifferButton(cornerRadius: self.buttonCompactSize / 2,
                                         imageSize: self.buttonCompactSize / 2)
            self.mainLabelFont(size: 25)
        }
        
        regularCallback = { [weak self] in
            guard let self = self else { return }
            self.responsiveSnifferButton(cornerRadius: self.buttonRegularSize / 2,
                                         imageSize: self.buttonRegularSize / 2)
            self.mainLabelFont(size: 40)
        }
        
        view.setGradientBackground(gradient: gradient,colors: [
            UIColor(resource: R.color.background)!.withAlphaComponent(0.4).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.5).cgColor,
            UIColor(resource: R.color.background)!.withAlphaComponent(0.6).cgColor,
        ])
        view.addSubview(snifferButton)
        view.addSubview(mainLabel)
        setupConstraints()
        super.viewDidLoad()
        displayBottomSheet()
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
    
    @objc func sniff() {
        startSniffButtonAnimation()
        animatableLayer.isHidden ? startSniffing() : {
            stopSniffing()
            displayBottomSheet()
        }()
    }
    
    private func startSniffing() {
        startRadioWaveAnimation()
        shMusicListDelegate?.dismiss()
        try? viewModel.shazamManager.startListening(delegate: self)
    }
    
    private func stopSniffing() {
        stopRadioWaveAnimation()
        viewModel.shazamManager.stopListening()
    }
    
    private func radioWaveAnimation() {
        animatableLayer.fillColor = UIColor(resource: R.color.primary)?.withAlphaComponent(0.4).cgColor
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
    
    private func stopRadioWaveAnimation() {
        animatableLayer.removeAnimation(forKey: "growingAnimation")
        animatableLayer.isHidden = true
    }
    
    private func startSniffButtonAnimation() {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [], animations: {
            self.snifferButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            AudioServicesPlayAlertSound(1519)
        }) { (finished) in
            self.snifferButton.transform = CGAffineTransform.identity
        }
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            snifferButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            snifferButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: snifferButton.topAnchor, constant: -40),
        ])
        
        regularConstraints.append(contentsOf: [
            snifferButton.widthAnchor.constraint(equalToConstant: buttonRegularSize),
            snifferButton.heightAnchor.constraint(equalToConstant: buttonRegularSize),
        ])
        
        compactConstraints.append(contentsOf: [
            snifferButton.widthAnchor.constraint(equalToConstant: buttonCompactSize),
            snifferButton.heightAnchor.constraint(equalToConstant: buttonCompactSize),
        ])
    }
    
    private func responsiveSnifferButton(cornerRadius: CGFloat, imageSize: CGFloat) {
        snifferButton.layer.cornerRadius = cornerRadius
        snifferButton.setImage(UIImage(resource: R.image.waveSound)?.resize(newWidth: imageSize), for: .normal)
    }
    
    private func mainLabelFont(size: CGFloat) {
        mainLabel.font = .boldSystemFont(ofSize: size)
    }
}

extension SnifferViewController: SnifferDelegate {
    func displayBottomSheet() {
        let viewController = SHMusicListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isModalInPresentation = true
        if let sheet = navigationController.sheetPresentationController {
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.detents = [.custom(resolver: { context in
                0.15 * context.maximumDetentValue
            }), .large()]
            self.shMusicListDelegate = viewController
            self.navigationController?.present(navigationController, animated: true)
        }
    }
}

extension SnifferViewController: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        DispatchQueue.main.async { [weak self] in
            self?.stopSniffing()
            if let viewController = self?.storyboard?.instantiateViewController(withIdentifier: R.storyboard.main.shMusicViewController) as? SHMusicViewController {
                Task {
                    do {
                        guard let matchedMediaItem = match.mediaItems.first,
                              let artworkURL = match.mediaItems.first?.artworkURL else {
                            fatalError("[Data] match.mediaItems.first or match.mediaItems.first?.artworkURL is nil.")
                        }
                        
                        let data = try await viewController.viewModel.getRemoteImage(url: artworkURL).get()
                        viewController.music = Music(matchedMediaItem, artwork: data)
                        viewController.snifferDelegate = self
                        DispatchQueue.main.async {
                            self?.navigationController?.present(viewController, animated: true)
                        }
                    } catch {
                        self?.displayAlert(title: R.string.sniffer.getDataErrorTitle.callAsFunction(),
                                           message: R.string.sniffer.getDataErrorTitle.callAsFunction())
                    }
                }
            }
        }
    }
    
    private func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.general.ok.callAsFunction(), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.stopSniffing()
            self?.displayAlert(title: R.string.sniffer.didNotFindMatchTitle.callAsFunction(),
                         message: R.string.sniffer.didNotFindMatchMessage.callAsFunction())
        }
    }
}
