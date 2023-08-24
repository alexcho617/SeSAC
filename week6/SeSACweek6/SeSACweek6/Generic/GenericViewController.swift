//
//  GenericViewController.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/24.
//

import UIKit
import SnapKit
class GenericViewController: UIViewController {

    let llabel = UILabel()
    let bbuton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Titltltle"
        view.backgroundColor = .white
        ///Generic: 타입에 유연하게 대응하기 위해 사용
        ///코드 중복과 재사용에 대응하기 좋아 추상적인 표현 가능
        let genericVal = sumGeneric(a: 1.1, b: 1)
        let intVal = sum(a: 3, b: 4)
        let doubleVal = sum(a: 3.5, b: 3.2)
        
        view.addSubview(llabel)
        view.addSubview(bbuton)
        bbuton.setTitle("Press Me", for: .normal)
        llabel.text = "Im Label"
        
        bbuton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(50)
        }
        configureBorder(view: bbuton)
        
        llabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(100)
            make.top.equalTo(bbuton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        configureBorder(view: llabel)
        
    }
    

}
