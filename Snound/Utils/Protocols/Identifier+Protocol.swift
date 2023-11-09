//
//  Identifier.swift
//  Snound
//
//  Created by Valentin Mont on 09/11/2023.
//

import Foundation
import SQLite

protocol Identifier {
    static var name: Table { get }
}
