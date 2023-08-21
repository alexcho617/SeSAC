//
//  AppDelegate.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //알림 권한 설정: 보통 푸쉬는 처음에 설정한다. 카메라 위치 등은 필요할 때 요청한다.
        //UN: User Notification, UI = User Interaction 등 애플은 접두어를 붙힘
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge,]) { success, error in
            print(success, error)
        }
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

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    //foreground notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //특정화면에서, 특정 조건에서만 받기 특정화면에선 안받기
        completionHandler([.sound,.badge,.banner,.list])
        
        //특정 푸시 클릭하면 어떠한 화면으로 이동 - Deep linking
        //알림 갯수 제한: 하루에 identifier기반으로 64개가 제한 되어있다. 그렇다면 챗 서비스 들은? 64개의 카톡방만 제한 되어있나?
        //카톡은 메신저이기 때문에 매우 복잡하게 대응을 해놨을것으로 예상
        //카톡은 켜기만하면 모든 알림이 다 사라진다. -> 포어그라운드로 앱을 키는 순간 등록되어있는 모든 알림들을 제거.
        //만약 알림을 차단했거나 나간 톡방에 대해 모두 대응을 해야한다면 많은 케이스들이 생길것. 차라리 모두 지우는게 낫다는 판단
        //잔디는 업무 기반이기 때문에 다른 정책을 사용
    }
}
