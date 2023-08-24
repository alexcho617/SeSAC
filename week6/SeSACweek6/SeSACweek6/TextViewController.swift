//
//  TextViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit
class TextViewController: UIViewController {
    
    //image 1 declare
    let picker = UIImagePickerController()
    let fontPicker = UIFontPickerViewController() // 시스템 폰트 고를 수 있음
    let colorPicker = UIColorPickerViewController()
    //closure: unnamed method with call
    //재사용이 떨어지지만 한곳에서만 쓸 경우 용이
    let imageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.placeholder = "Enter Text"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 12)
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //1
//        view.addSubview(imageView)
//        view.addSubview(titleTextField)
        
        
        //2
//        for item in [imageView,titleTextField]{
//            view.addSubview(item)
//        }
        
        //3
        let views = [imageView,titleTextField]
        //closure
        views.forEach { view.addSubview($0) }
        
        setUpConstraints()
    }
    
    //여기서 호출했기 때문에 카메라를 사용하면 계속 다시 함수가 실행됨
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        presentPicker()
    }
    
    fileprivate func setUpConstraints() {
        
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20) //imageview 기준으로 잡기 때문에 imageview 먼저 실행해야함
            make.leadingMargin.equalTo(20) //make.leading.equalTo(view).inset(20) 같음
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    func presentPicker(){
        //image2 avilable: Camera needs privacy auth
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("No Gallery:Present Alert")
            return
        }
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
//        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
}

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //NC Delegate: Picker내에 앨범 등 이동이 필요한경우
    
    //자주 쓰는 함수
    //1 Selected Photo from Library/Camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지가 돌아가있는경우 수정으로 돌려야함
        //dictionary
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imageView.image = image
            dismiss(animated: true)
        }
        
    }
    //2 canceled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}
