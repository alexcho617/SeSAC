//
//  SceneDelegate.swift
//  SearchExample
//
//  Created by jack on 2023/08/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       //_ wildcard에서 scene으로
        guard let scene = (scene as? UIWindowScene) else { return }
        
        //window 새로 생성
        window = UIWindow(windowScene: scene)
        
        //Debug
        UserDefaults.standard.set(false, forKey: "isLaunched")

        
        //1 initial launch
        let isLaunched = UserDefaults.standard.bool(forKey: "isLaunched")
        print(#file,#line,isLaunched)
        
        if isLaunched == false{
            //2first launch
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FirstViewViewController") as! FirstViewViewController
            
            //rootview 설정
            window?.rootViewController = vc
        }else{
            //3 library launch
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LibraryCollectionViewController") as! LibraryCollectionViewController
            let nav = UINavigationController(rootViewController: vc) //이건 왜 필요하지
            window?.rootViewController = nav
        }
        
        //최종 보여달라는 코드
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

