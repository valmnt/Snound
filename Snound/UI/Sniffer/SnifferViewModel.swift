//
//  SnifferViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 27/10/2023.
//

import Foundation

class SnifferViewModel: SNViewModel {
    
    let shazamManager: SHManager = SHManager()
    
    var allMusicCount: Int {
        Music.getAllMusic(database: dbSQLite!).count
    }
}
