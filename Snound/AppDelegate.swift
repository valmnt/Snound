//
//  AppDelegate.swift
//  Snound
//
//  Created by Valentin Mont on 10/10/2023.
//

import UIKit
import SQLite

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private(set) var databaseSQLite: Connection?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initSQLite()
        return true
    }
    
    private func initSQLite() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            
            databaseSQLite = try Connection("\(path)/db.sqlite3")
            
            try databaseSQLite?.run(MusicTable.name.create(ifNotExists: true, block: { t in
                t.column(MusicTable.title, unique: true)
                t.column(MusicTable.artist)
                t.column(MusicTable.artwork)
                t.column(MusicTable.appleMusicURL)
            }))
        } catch {
            NSLog("[SQLite] An error occured while initializing the database.", error.localizedDescription)
        }
    }
}

