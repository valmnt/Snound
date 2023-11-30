//
//  SettingsViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 23/11/2023.
//

import Foundation

class SettingsViewModel: SNViewModel {
    
    func deleteAllData() -> Result<Bool, Error> {
        do {
            _ = try dbSQLite?.run(MusicTable.name.delete())
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
