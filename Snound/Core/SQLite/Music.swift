//
//  Music.swift
//  Snound
//
//  Created by Valentin Mont on 02/11/2023.
//

import Foundation
import SQLite

struct Music {
    static let table = Table("musics")
    static let title = Expression<String>("title")
    static let artist = Expression<String>("artist")
    static let artworkURL = Expression<URL>("artworkURL")
    static let appleMusicURL = Expression<URL>("appleMusicURL")
}
