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
            print(error)
            return nil
        }
    }
    
    func insertIntoDatabase(_ item: SHMatchedMediaItem) {
        do {
            guard let title = item.title else { fatalError("Empty title") }
            try dbSQLite?.run(Music.table.insert(Music.title <- title))
        } catch {
            print(error)
        }
    }
}
