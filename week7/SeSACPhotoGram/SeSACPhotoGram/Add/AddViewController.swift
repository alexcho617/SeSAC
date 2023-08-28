//
//  ViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {
    let mainView = AddView()
    //view lifecycle: VDL보다 먼저 실행됨
    //super 호출하면 안됨: 애플의 뷰컨에서 사용하는게 호출 될 수도 있음
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //selector, name
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)

    }
    
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    override func configureView(){
        super.configureView()
        mainView.searchButon.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification){
        guard let name = notification.userInfo?["name"] as? String else{ return }
        mainView.photoImageView.image = UIImage(systemName: name)
    }
    
    @objc func searchButtonClicked(){
        let word = ["1","2","3","4","5"]
        let vc = SearchViewController()
        sleep(1)
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKey"), object: nil, userInfo: ["word":word.randomElement()!])
        present(vc, animated: true)
    }
}


