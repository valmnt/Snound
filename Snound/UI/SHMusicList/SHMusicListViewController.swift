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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SHMusicListViewController: SHMusicListDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}
