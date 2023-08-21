//
//  SeSACButton.swift
//  SeSAC3Week5
//
//  Created by Alex Cho on 2023/08/21.
//

import Foundation
import UIKit

//컴파일 타임 확인 가능
@IBDesignable
class SeSACButton: UIButton{
    
    @IBInspectable //스토리보드에 보여지게 됨
    var alexCornerRadius: CGFloat{
        get{ return layer.cornerRadius }
        set{ layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat{
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor{
        get {return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
        
    }
}
