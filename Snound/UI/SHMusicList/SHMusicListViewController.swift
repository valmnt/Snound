//
//  SHMusicListViewController.swift
//  Snound
//
//  Created by Valentin Mont on 08/11/2023.
//

import Foundation
import UIKit

protocol SHMusicListDelegate: NSObject {
    func dismiss()
}

class SHMusicListViewController: SNViewController {
    
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
    
    override var backgroundColor: UIColor? {
        UIColor(resource: R.color.backgroundLight)
    }
    
    override func viewDidLoad() {
        view.addSubview(topBar)
        setupConstraints()
        super.viewDidLoad()
    }
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBar.widthAnchor.constraint(equalToConstant: 100),
            topBar.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}

extension SHMusicListViewController: SHMusicListDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
