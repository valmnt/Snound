//
//  Music.swift
//  Snound
//
//  Created by Valentin Mont on 09/11/2023.
//

import Foundation
import SQLite

struct Music {
    
    let title: String
    let artist: String
    let artwork: Data
    let appleMusicURL: URL
    
    init(_ row: Row) {
        title = row[MusicTable.title]
        artist = row[MusicTable.artist]
        artwork = row[MusicTable.artwork]
        appleMusicURL = row[MusicTable.appleMusicURL]
    }
}
