//
//  SHMusicViewController.swift
//  Snound
//
//  Created by Valentin Mont on 28/10/2023.
//

import Foundation
import ShazamKit
import UIKit

class SHMusicViewController: UIViewController {
    
    var shMusic: SHMatchedMediaItem?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let artworkURL = shMusic?.artworkURL, let data = try? Data(contentsOf: artworkURL) {
//            imageView.image = UIImage(data: data)
//            view.addSubview(imageView)
//        }
    }
}
