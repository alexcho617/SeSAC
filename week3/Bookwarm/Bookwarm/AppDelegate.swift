//
//  AppDelegate.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 4){
            
            migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.renameProperty(onType: RealmBook.className(), from: "thumbnail", to: "thumbnailImageURL")
            } // thumbnail -> thumbnailImageURL
            
            if oldSchemaVersion < 2{
                migration.renameProperty(onType: RealmBook.className(), from: "url", to: "webPageURL")
                
            }//url -> webPageUrl
            
            if oldSchemaVersion < 3{
                migration.renameProperty(onType: RealmBook.className(), from: "isLiked", to: "userDidLike")
            }//isLiked -> userDidLike
            
        }
        
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

