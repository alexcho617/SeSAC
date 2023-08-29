//
//  TabViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TrendViewController.identifier) as! TrendViewController)
        mainVC.tabBarItem.title = "Main"
        mainVC.tabBarItem.image = UIImage(systemName: "star")
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        self.viewControllers = [profileVC,mainVC]

    }
    
   

}
