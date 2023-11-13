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
    
    private let collectionCellWidth: CGFloat = 170
    private let height: CGFloat = 300
    
    private var numberPerRow: Int {
        max(1, Int(view.frame.width / collectionCellWidth))
    }
    
    private var numberOfRows: Int {
        Int(round(Double(viewModel.allMusic.count) / Double(numberPerRow)))
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = view.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        label.text = R.string.musicList.yourMusic.callAsFunction()
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
        view.addSubview(tableView)
        
        setupTableView()
        setupConstraints()
        
        super.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
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
            
            
            tableView.topAnchor.constraint(equalTo: yourMusicLabel.bottomAnchor, constant: 50),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
    }
}

extension SHMusicListViewController: SHMusicListDelegate {
    func dismiss() {
        dismiss(animated: true)
    }
}

extension SHMusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
}

extension SHMusicListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as? MusicTableViewCell else {
            return UITableViewCell()
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: collectionCellWidth, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cell.collectionView = MusicCollectionView(frame: view.frame, collectionViewLayout: layout)
        
        guard let collectionView = cell.collectionView else { return UITableViewCell() }
        collectionView.isScrollEnabled = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cell.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
        ])
        
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "MusicCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(resource: R.color.backgroundLight)
        collectionView.tableViewRow = indexPath.row
        return cell
    }
}

extension SHMusicListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberPerRow
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCollectionViewCell", for: indexPath) as? MusicCollectionViewCell,
              let tableViewRow = (collectionView as? MusicCollectionView)?.tableViewRow else {
            return UICollectionViewCell()
        }
        
        let index = tableViewRow * numberPerRow + indexPath.row
        
        if index < viewModel.allMusic.count {
            let music = viewModel.allMusic[index]
            cell.imageView.image = UIImage(data: music.artwork)
            cell.titleLabel.text = music.title
            cell.artistLabel.text = music.artist
            cell.setup()
        } else {
            cell.isHidden = true
        }
        
        return cell
    }
}

extension SHMusicListViewController: UICollectionViewDelegate {}

class MusicCollectionView: UICollectionView {
    var tableViewRow: Int?
}

class MusicTableViewCell: UITableViewCell {
    var collectionView: MusicCollectionView?
}

class MusicCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: R.color.primary)?.withAlphaComponent(0.7)
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup() {
        backgroundColor = UIColor(resource: R.color.background)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(artistLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 40),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
}
