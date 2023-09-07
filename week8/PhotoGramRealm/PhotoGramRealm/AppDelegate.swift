//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let config = Realm.Configuration(schemaVersion: 5){
//            migration, oldSchemaVersion in
//            //개별적으로 올리는 이유는 앱 사용자가 쓰는 버전에서 하나씩 올려줘야하기 때문이다
//            //앱 샌드박스의 구조 또한 바뀌기 때문에 다시 default.realm 위치도 찾아야한다
//            //Column, Table의 단순 추가 삭제경우엔 별도 코드가 필요없음
//            if oldSchemaVersion < 1 {} //diaryPin Column 추가
//            if oldSchemaVersion < 2 {} //diaryPin Column 삭제
//
//            //컬럼 이름 변경
//            if oldSchemaVersion < 3 {
//                migration.renameProperty(onType: Diary.className(), from: "PhotoURL", to: "photo")
//            } //Column Name Changed: PhotoURL -> photo
//
//            //컬럼 이름 변경
//            if oldSchemaVersion < 4 {
//                migration.renameProperty(onType: Diary.className(), from: "content", to: "contents")
//            } //Column Name Changed: content -> contents
//
//            //기존 컬럼을 사용하여 새로운 컬럼 생성
//            if oldSchemaVersion < 5 {
//                migration.enumerateObjects(ofType: Diary.className()) { oldObject, newObject in
//                    guard let new = newObject else {return}
//                    guard let old = oldObject else {return}
//                    new["summary"] = "제목은:\(old["title"])  내용은:\(old["contents"])"
//
//                }
//            } //title +  contents 를 합쳐서 summary 생성
//
//        }
        
        
//        Realm.Configuration.defaultConfiguration = config
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

