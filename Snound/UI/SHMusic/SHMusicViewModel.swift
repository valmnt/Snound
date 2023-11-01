//
//  SHMusicViewModel.swift
//  Snound
//
//  Created by Valentin Mont on 01/11/2023.
//

import Foundation

class SHMusicViewModel {
    
    func getRemoteImage(url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return data
        } catch {
            print(error)
            return nil
        }
    }
}
