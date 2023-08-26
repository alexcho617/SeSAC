//
//  PosterImageView.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/25.
//

import UIKit
class PosterImageView: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
    }

    func configureView(){
        print(frame)
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        //원을 만들려면 frame 기준 반으로 주어야 원이 됨. 그렇다면 frame이 먼저 정해져야하는데 생성 순서상 불가능하다.
        //해결 방법 1: 이렇게 하면 독립적인 작업으로 할당 되어 frame이 잡힌 후 설정 된다.
//        DispatchQueue.main.async {
//            print(self.frame)
//            self.layer.cornerRadius = self.frame.width/2
//        }
    }
    //UIView가 생성되며 거치는 많은 함수들 중 하나. 시점은 현재 뷰 생성 후이며 하위 뷰들을 설정하는 용도
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //여기서 호출 하면 뷰 생성후에 됨
        print(#function, frame)
        layer.cornerRadius = frame.width/2

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
