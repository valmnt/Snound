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
}
