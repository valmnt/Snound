//
//  SettingsViewController.swift
//  Snound
//
//  Created by Valentin Mont on 18/11/2023.
//

import Foundation
import UIKit

class SettingsViewController: SNViewController {
    
    private let viewModel: SettingsViewModel = SettingsViewModel()
    
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
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.settings.deleteData.callAsFunction(), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(displayWarningAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: R.color.backgroundLight)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        compactCallback = { [weak self] in
            guard let self = self else { return }
            self.warningLabel.font = .systemFont(ofSize: 18)
            self.versionLabel.font = .systemFont(ofSize: 16)
            self.deleteButton.titleLabel?.font = .systemFont(ofSize: 18)
        }
        
        regularCallback = { [weak self] in
            guard let self = self else { return }
            self.warningLabel.font = .systemFont(ofSize: 28)
            self.versionLabel.font = .systemFont(ofSize: 20)
            self.deleteButton.titleLabel?.font = .systemFont(ofSize: 28)
        }
        
        view.addSubview(warningLabel)
        view.addSubview(versionLabel)
        view.addSubview(deleteButton)
        view.addSubview(separatorView)
        
        setupConstraints()
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func displayWarningAlert() {
        let alert = UIAlertController(title: R.string.settings.dataDeletionAlertTitle.callAsFunction(), message: R.string.settings.dataDeletionAlertMessage.callAsFunction(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.general.no.callAsFunction(), style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: R.string.general.yes.callAsFunction(), style: .destructive) { _ in
            let result = try? self.viewModel.deleteAllData().get()
            if !(result ?? false) {
                let alert = UIAlertController(title: R.string.settings.deletionErrorTitle.callAsFunction(), message: R.string.settings.deletionErrorMessage.callAsFunction(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: R.string.general.ok.callAsFunction(), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: 5),
            deleteButton.heightAnchor.constraint(equalToConstant: 100),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 3),
        ])
        
        compactConstraints.append(contentsOf: [
            warningLabel.heightAnchor.constraint(equalToConstant: 100),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        regularConstraints.append(contentsOf: [
            warningLabel.heightAnchor.constraint(equalToConstant: 200),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        ])
    }
}
