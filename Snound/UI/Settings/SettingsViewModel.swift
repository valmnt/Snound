//
//  SettingsViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 23/11/2023.
//

import Foundation

class SettingsViewModel: SNViewModel {
    
    func deleteAllData() {
        _ = try? dbSQLite?.run(MusicTable.name.delete())
    }
}
