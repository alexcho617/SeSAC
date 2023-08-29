//
//  ViewController.swift
//  SeSACPhotoGram
//
//  Created by Alex Cho on 2023/08/28.
//

import UIKit
import SeSACPhotoFramework
class AddViewController: BaseViewController {
    let mainView = AddView()
    //view lifecycle: VDL보다 먼저 실행됨
    //super 호출하면 안됨: 애플의 뷰컨에서 사용하는게 호출 될 수도 있음
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //vDL에 있던걸 vWA로 옮김
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        //selector, name //Observer 등록
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
//functions from framework
//        sesacShowAlert(title: "title", message: "message", buttonTitle: "buttonTitle") { action in
//            print(action.title)
//        }
//        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "helloo", text: "hiii")
    }
    
    //이 시점에 하면 이미지 반영이 당연히 안될거임
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print(#function)
//        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
//    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    override func configureView(){
        super.configureView()
        mainView.searchButon.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.searchProtocolButon.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.labelButton.addTarget(self, action: #selector(labelButtonClicked), for: .touchUpInside)


    }
    
    @objc func dateButtonClicked(){
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification){
        print(#function)
        guard let name = notification.userInfo?["name"] as? String else{ return }
        mainView.photoImageView.image = UIImage(systemName: name)
    }
    
    @objc func searchButtonClicked(){
        let word = ["1","2","3","4","5"]
        let vc = SearchViewController()
        //이게 안됨
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKey"), object: nil, userInfo: ["word":word.randomElement()!])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked(){
        let vc = SearchViewController()
        //4
        vc.delegate = self
        present(vc,animated: true)
    }
    
    
    @objc func titleButtonClicked(){
        let vc = TitleViewController()
        
        //closure 3 - 함수 내용이 vc.completionHandler에 들어감
//        vc.completionHandler = { response in
//            print("completionHandler")
//            //self가 필요한 이유는 해당VC에 있다는걸 명시하는건가?
//            self.mainView.titleButton.setTitle(response, for: .normal)
//        }
        
        //closure 3 - 여러 값
        vc.completionHandler = { title, age, push in
            print("completionHandler")
            //self가 필요한 이유는 해당VC에 있다는걸 명시하는건가?
            self.mainView.titleButton.setTitle(title, for: .normal)
            print(title,age,push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func labelButtonClicked(){
        let vc = TextViewController()
        
        //closure 3 - 함수 내용이 vc.completionHandler에 들어감
        vc.completionHandler = { response in
            print("completionHandler")
            //self가 필요한 이유는 해당VC에 있다는걸 명시하는건가?
            self.mainView.labelButton.setTitle(response, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}



//실질적 함수 기능
extension AddViewController: PassDataDelegate{
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

//5
extension AddViewController: PassImageDelegate{
    func passImage(image: String) {
        print(image)
        mainView.photoImageView.image = UIImage(systemName: image)
    }
}
