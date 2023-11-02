//
//  SHMusicViewController.swift
//  Snound
//
//  Created by Valentin Mont on 28/10/2023.
//

import Foundation
import ShazamKit
import UIKit

class SHMusicViewController: SNViewController {
    
    let viewModel: SHMusicViewModel = SHMusicViewModel()
    
    var shMusicImage: UIImage?
    var shMusic: SHMatchedMediaItem?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.65)
        return blurEffectView
    }()
    
    private lazy var songLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 27)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: R.color.primary)?.withAlphaComponent(0.4)
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let upwardsBlurEdge = UpwardsBlurEdge()
    
    private lazy var appleMusicButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "airpodsmax")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        configuration.imagePadding = 10
        configuration.background.backgroundColor = UIColor(resource: R.color.appleMusic)
        configuration.cornerStyle = .capsule
        
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 18)
        configuration.attributedTitle = AttributedString("Full song", attributes: container)
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(redirectToAppleMusic), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        guard let shMusicImage = shMusicImage else { return }
        
        blurEffectView.backgroundColor = UIColor(patternImage: shMusicImage)
        
        imageView.image = shMusicImage
        imageView.contentMode = .scaleAspectFit
        
        upwardsBlurEdge.translatesAutoresizingMaskIntoConstraints = false
        upwardsBlurEdge.backgroundColor = UIColor(resource: R.color.background)
        
        songLabel.text = shMusic?.title
        artistLabel.text = shMusic?.artist
        
        view.addSubview(blurEffectView)
        view.addSubview(imageView)
        view.addSubview(upwardsBlurEdge)
        view.addSubview(songLabel)
        view.addSubview(artistLabel)
        view.addSubview(appleMusicButton)
        
        setupConstraints()
        super.viewDidLoad()
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo: blurEffectView.heightAnchor, constant: -40),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            upwardsBlurEdge.widthAnchor.constraint(equalTo: view.widthAnchor),
            upwardsBlurEdge.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            appleMusicButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 50),
            appleMusicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleMusicButton.widthAnchor.constraint(equalToConstant: 200),
            appleMusicButton.heightAnchor.constraint(equalToConstant: 55),
        ])
        
        compactConstraints.append(contentsOf: [
            upwardsBlurEdge.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            songLabel.topAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -40),
            songLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        regularConstraints.append(contentsOf: [
            upwardsBlurEdge.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 20),
            
            songLabel.topAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: 10),
            songLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            artistLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        ])
    }
    
    @objc private func redirectToAppleMusic() {
        guard let appleMusicURL = shMusic?.appleMusicURL else { return }
        UIApplication.shared.open(appleMusicURL )
    }
}