//
//  SHMusicListViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 09/11/2023.
//

import Foundation

class SHMusicListViewModel: SNViewModel {
    
    lazy var allMusic: [Music] = {
        Music.getAllMusic(database: dbSQLite)
    }()
}
