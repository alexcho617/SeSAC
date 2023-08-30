//
//  UIViewController+Extension.swift
//  SeSACPhotoFramework
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit
extension UIViewController{
    
    public func sesacShowAlert(title: String, message: String, actionOneTitle: String, actionOne: @escaping (UIAlertAction) -> Void, actionTwoTitle: String, actionTwo: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let menuOne = UIAlertAction(title: actionOneTitle, style: .default, handler: actionOne)
        let menuTwo = UIAlertAction(title: actionTwoTitle, style: .default, handler: actionTwo)
        alert.addAction(cancel)
        alert.addAction(menuOne)
        alert.addAction(menuTwo)
        present(alert, animated: true)
        
    }
    
    //공유버튼
    public func sesacShowActivityViewController(image: UIImage, url: String, text: String){
        let vc = UIActivityViewController(activityItems: [image,url,text], applicationActivities: nil)
        //메뉴에서 제거
        vc.excludedActivityTypes = [.mail, .message]
        present(vc, animated: true)
    }
}
