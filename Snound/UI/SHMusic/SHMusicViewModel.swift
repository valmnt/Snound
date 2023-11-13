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
    
    func insertIntoDatabase(_ item: Music) {
        do {
            try dbSQLite?.run(MusicTable.name.insert(
                MusicTable.title <- item.title,
                MusicTable.artist <- item.artist,
                MusicTable.artwork <- item.artwork,
                MusicTable.appleMusicURL <- item.appleMusicURL
            ))
        } catch {
            NSLog("[SQLite] An error occured while inserting a music into the database.", error.localizedDescription)
        }
    }
}
