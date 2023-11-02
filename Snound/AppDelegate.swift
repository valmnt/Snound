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
    
    private(set) var databaseSQL: Connection?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initSQL()
        return true
    }
    
    private func initSQL() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            
            databaseSQL = try Connection("\(path)/db.sqlite3")
        } catch {
            print(error)
        }
    }
}

