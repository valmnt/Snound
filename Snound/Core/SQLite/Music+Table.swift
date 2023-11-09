//
//  Music.swift
//  Snound
//
//  Created by Valentin Mont on 02/11/2023.
//

import Foundation
import SQLite

class MusicTable: Identifier {
    static var name = Table("music")
    static let title = Expression<String>("title")
    static let artist = Expression<String>("artist")
    static let artwork = Expression<Data>("artwork")
    static let appleMusicURL = Expression<URL>("appleMusicURL")
}
