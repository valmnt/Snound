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
        self.title = matchedMediaItem.title ?? R.string.general.unknow.callAsFunction()
        self.artist = matchedMediaItem.artist ?? R.string.general.unknow.callAsFunction()
        self.artwork = artwork
        self.appleMusicURL = matchedMediaItem.appleMusicURL
    }
    
    static func getAllMusic(database: Connection) -> [Music] {
        var allMusic: [Music] = []
        do {
            for music in try database.prepare(MusicTable.name) {
                allMusic.append(Music(music))
            }
        } catch {
            print(error)
        }
        return allMusic
    }
}
