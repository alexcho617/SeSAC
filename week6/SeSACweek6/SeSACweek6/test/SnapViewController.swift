//
//  SnapViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit

/*
 addSubview
 superView
 offset inset
 */
class SnapViewController: UIViewController {
    let blueview = UIView()
    let whiteView = UIView()
    let redView = UIView()
    let yellowView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(blueview)
        blueview.backgroundColor = .blue
        blueview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.frame.height/3)
        }
        
        view.addSubview(redView)
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height/3)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        view.addSubview(whiteView)
        whiteView.backgroundColor = .white
        whiteView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(view.frame.height/3)
            make.width.equalTo(view.frame.width)
        }
        
        blueview.addSubview(yellowView)
        yellowView.backgroundColor = .yellow
        yellowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
            make.edges.equalToSuperview().inset(50)


        }

    }
    
}
