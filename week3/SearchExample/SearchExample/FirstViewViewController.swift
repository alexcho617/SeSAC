//
//  FirstViewViewController.swift
//  SearchExample
//
//  Created by Alex Cho on 2023/08/04.
//

import UIKit

class FirstViewViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print(#function)
    }
    
    deinit{
        print("Deinitialized from memory") //이건 어떻게 호출 되는거지?? override도 안했는데 ㄷㄷ static func?
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "isLaunched")
        print(UserDefaults.standard.bool(forKey: "isLaunched"))
    }

    @IBAction func mainButtonClicked(_ sender: UIButton) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene //first는 첫번째 scene 아이폰에선 애초에 하나밖에 없다
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LibraryCollectionViewController") as! LibraryCollectionViewController
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
}
