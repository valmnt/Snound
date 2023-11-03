//
//  SHMusicViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 01/11/2023.
//

import Foundation
import ShazamKit
import SQLite

class SHMusicViewModel: SNViewModel {
    
    func getRemoteImage(url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return data
        } catch {
            NSLog("[URLSession] An error occurred while retrieving the song art.", error.localizedDescription)
            return nil
        }
    }
    
    func insertIntoDatabase(_ item: SHMatchedMediaItem) {
        do {
            guard let title = item.title,
                  let artist = item.artist,
                  let artworkURL = item.artworkURL,
                  let appleMusicURL = item.appleMusicURL else {
                 fatalError("Empty title")
             }
            
            try dbSQLite?.run(Music.table.insert(
                Music.title <- title,
                Music.artist <- artist,
                Music.artworkURL <- artworkURL,
                Music.appleMusicURL <- appleMusicURL
            ))
        } catch {
            NSLog("[SQLite] An error occured while inserting a music into the database.", error.localizedDescription)
        }
    }
}
