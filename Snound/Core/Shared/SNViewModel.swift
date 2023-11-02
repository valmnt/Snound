//
//  SNViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 02/11/2023.
//

import Foundation
import SQLite

class SNViewModel {
    var dbSQLite: Connection? {
        (UIApplication.shared.delegate as? AppDelegate)?.databaseSQLite
    }
}
