//
//  HomeViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/31.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func loadView() { //super method 호출 X: Apple의 UIView로 덮힐 수 있음
        let mainView = HomeView()
        mainView.delegate = self
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
    }
    
    //delegate를 연결하니 deinit이 안되고이씀
    deinit {
        print(#function, self)
    }
    
}

extension HomeViewController: HomeViewProtocol{
    func didSelectItemAt(indexPath: IndexPath) {
        
//        print(#function,indexPath)
        navigationController?.popViewController(animated: false)
    }
    
}
