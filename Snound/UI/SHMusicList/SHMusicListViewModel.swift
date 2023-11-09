//
//  SHMusicListViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 09/11/2023.
//

import Foundation

class SHMusicListViewModel: SNViewModel {
    
    var allMusic: [Music] = []
    
    func getAllMusic() {
        do {
            for music in try dbSQLite!.prepare(MusicTable.name) {
                allMusic.append(Music(music))
            }
        } catch {
            print(error)
        }
    }
}
