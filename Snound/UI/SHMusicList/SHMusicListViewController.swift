//
//  SHMusicListViewController.swift
//  Snound
//
//  Created by Valentin Mont on 08/11/2023.
//

import Foundation
import UIKit

protocol SHMusicListDelegate {
    func dismiss()
}

class SHMusicListViewController: SNViewController {
    
    private let viewModel: SHMusicListViewModel = SHMusicListViewModel()
    
    private lazy var topBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var yourMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Music"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.allMusic.count)"
        label.textColor = UIColor(resource: R.color.primary)
        label.font = .boldSystemFont(ofSize: 27)
        label.isHidden = viewModel.allMusic.isEmpty
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var backgroundColor: UIColor? {
        UIColor(resource: R.color.backgroundLight)
    }
    
    override func viewDidLoad() {
        viewModel.getAllMusic()
        
        view.addSubview(topBar)
        view.addSubview(yourMusicLabel)
        view.addSubview(counterLabel)
        
        setupConstraints()
        
        super.viewDidLoad()
    }
    
    private func setupConstraints() {
        sharedConstraints = [
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBar.widthAnchor.constraint(equalToConstant: 100),
            topBar.heightAnchor.constraint(equalToConstant: 10),
            
            counterLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 40),
            counterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            counterLabel.widthAnchor.constraint(equalToConstant: 50),
            
            yourMusicLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 40),
            yourMusicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yourMusicLabel.trailingAnchor.constraint(equalTo: counterLabel.leadingAnchor),
        ]
    }
}

extension SHMusicListViewController: SHMusicListDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
