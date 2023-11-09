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
    
    func getRemoteImage(url: URL) async -> Swift.Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            NSLog("[URLSession] An error occurred while retrieving the song art.", error.localizedDescription)
            return .failure(error)
        }
    }
    
    func insertIntoDatabase(item: SHMatchedMediaItem, image: UIImage) {
        do {
            guard let title = item.title,
                  let artist = item.artist,
                  let artwork = image.pngData(),
                  let appleMusicURL = item.appleMusicURL else {
                 return
             }
            
            try dbSQLite?.run(Music.table.insert(
                Music.title <- title,
                Music.artist <- artist,
                Music.artwork <- artwork,
                Music.appleMusicURL <- appleMusicURL
            ))
        } catch {
            NSLog("[SQLite] An error occured while inserting a music into the database.", error.localizedDescription)
        }
    }
}
