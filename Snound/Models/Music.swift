//
//  Music.swift
//  Snound
//
//  Created by Valentin Mont on 09/11/2023.
//

import Foundation
import SQLite
import ShazamKit

struct Music {
    
    let title: String
    let artist: String
    let artwork: Data
    let appleMusicURL: URL?
    
    init(_ row: Row) {
        title = row[MusicTable.title]
        artist = row[MusicTable.artist]
        artwork = row[MusicTable.artwork]
        appleMusicURL = row[MusicTable.appleMusicURL]
    }
    
    init(_ matchedMediaItem: SHMatchedMediaItem, artwork: Data) {
        self.title = matchedMediaItem.title ?? "Unknow"
        self.artist = matchedMediaItem.artist ?? "Unknow"
        self.artwork = artwork
        self.appleMusicURL = matchedMediaItem.appleMusicURL
    }
}
