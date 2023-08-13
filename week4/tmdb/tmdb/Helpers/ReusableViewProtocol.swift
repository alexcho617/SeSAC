//
//  ReusableViewProtocol.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/13.
//

import UIKit

protocol ReusableViewProtocol{
    static var identifier: String {get}
}

extension UIViewController: ReusableViewProtocol{
   
    
    static var identifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol{
 
    
    static var identifier: String{
        return String(describing: self)
    }
}
