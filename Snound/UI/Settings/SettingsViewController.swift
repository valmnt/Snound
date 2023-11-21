//
//  SettingsViewController.swift
//  Snound
//
//  Created by Valentin Mont on 18/11/2023.
//

import Foundation
import UIKit

class SettingsViewController: SNViewController {
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.settings.deletionWarning.callAsFunction()
        label.textColor = .white
        label.numberOfLines = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var versionLabel: UILabel = {
        let label = UILabel()
        let versionText = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        label.text = "Snound \(versionText ?? "")"
        label.textColor = UIColor(resource: R.color.primary)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        compactCallback = { [weak self] in
            guard let self = self else { return }
            self.warningLabel.font = .systemFont(ofSize: 18)
            self.versionLabel.font = .systemFont(ofSize: 16)
        }
        
        regularCallback = { [weak self] in
            guard let self = self else { return }
            self.warningLabel.font = .systemFont(ofSize: 28)
            self.versionLabel.font = .systemFont(ofSize: 20)
        }
        
        view.addSubview(warningLabel)
        view.addSubview(versionLabel)
        
        setupConstraints()
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        compactConstraints.append(contentsOf: [
            warningLabel.heightAnchor.constraint(equalToConstant: 100),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        regularConstraints.append(contentsOf: [
            warningLabel.heightAnchor.constraint(equalToConstant: 200),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
