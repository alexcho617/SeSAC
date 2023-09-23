//
//  Constants.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/22.
//

import Foundation
import UIKit

enum Constant{
    enum Text{
        static let title = UIColor(named: "title")!
    }
    
    enum Image{
        static let star = UIImage(systemName: "star")!.withRenderingMode(.alwaysOriginal).withTintColor(Constant.Text.title)
    }
}
