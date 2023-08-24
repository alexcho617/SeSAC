//
//  Extension + UIViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit
extension UIViewController{

    //conform protocol
    func sumGeneric<Alex: AdditiveArithmetic>(a: Alex, b: Alex) -> Alex{
        return a + b
    }
    
    func sum(a: Int, b: Int) -> Int{
        return a + b
    }
    func sum(a: Double, b: Double) -> Double{
        return a + b
    }
    
    //The Type Parameter "T" has Type Constraint with class or protocol
    func configureBorder<T: UIView>(view: T){
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    enum TransitionStyle{
        case present
        case presentWithNavigation
        case presentFullWithNavigation
        case push
    }
    
    //viewController의 타입 그 자체가 들어온다
    func transition<T: UIViewController>(style: TransitionStyle,viewController: T.Type){
        let vc = T()
        switch style {
        case .present:
            present(vc,animated: true)
        case .presentWithNavigation:
            let nc = UINavigationController(rootViewController: vc)
            present(nc, animated: true)
        case .presentFullWithNavigation:
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc,animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
