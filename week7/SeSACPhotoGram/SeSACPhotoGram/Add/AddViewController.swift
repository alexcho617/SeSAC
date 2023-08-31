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
    let imagePicker = UIImagePickerController() //영상은 못불러옴

    //view lifecycle: VDL보다 먼저 실행됨. super 호출하면 안됨: 애플의 뷰컨에서 사용하는게 호출 될 수도 있음
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //vDL에 있던걸 vWA로 옮김
    override func viewWillAppear(_ animated: Bool) {
        //Observer 등록selector, name이 중요 인자
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
    }
    
    deinit {
        print("deinit", self)
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    override func configureView(){
        super.configureView()
        
        //MARK: Actions
        mainView.rightSearchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.leftSearchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        mainView.labelButton.addTarget(self, action: #selector(labelButtonClicked), for: .touchUpInside)
    }
    
    func presentImagePicker(){
        //image2 avilable: Camera needs privacy auth
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Present Alert")
            return
        }
        imagePicker.delegate = self
        imagePicker.sourceType = .camera //카메라 가능. Privacy 권한 필요
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func dateButtonClicked(){
//        let vc = DateViewController()
//        vc.delegate = self
//        navigationController?.pushViewController(vc, animated: true)
        
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification){
        guard let imageURL = notification.userInfo?["name"] as? String else{ return }
        mainView.photoImageView.kf.setImage(with: URL(string: imageURL))
    }
    
    @objc func searchButtonClicked(){
        sesacShowAlert(title: "사진", message: "메뉴에서 선택", actionOneTitle: "검색", actionOne: { actionOne in
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        }, actionTwoTitle: "촬영") { actionTwo in
            self.presentImagePicker()
        }
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
        vc.completionHandler = { title, age, push in
            print("completionHandler")
            //self가 필요한 이유는 해당VC에 있다는걸 명시하는건가?
            self.mainView.titleButton.setTitle(title, for: .normal)
            print(title,age,push)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func labelButtonClicked(){
        let vc = ContentViewController()
        vc.completionHandler = { response in
            print("completionHandler")
            self.mainView.labelButton.setTitle(response, for: .normal)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

//5 실질적 함수 기능
extension AddViewController: PassDataDelegate, PassImageDelegate{
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
    
    func passImage(image: String) {
        print(image)
        mainView.photoImageView.image = UIImage(systemName: image)
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //1 Selected Photo from Library/Camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.mainView.photoImageView.image = image
            dismiss(animated: true)
        }
    }
    //2 Pressed Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}
