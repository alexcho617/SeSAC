//
//  ThreeViewController.swift
//  week6-assign
//
//  Created by Alex Cho on 2023/08/22.
//

import UIKit
import SnapKit

class ThreeViewController: UIViewController {
    private static let labelStrings = ["10월 24일 09시 42분", "서울, 신림동","지금은 9C 에요", "78% 만큼 습해요", "1m/s의 바람이 불어요","오늘도 행복한 하루 보내세요"]
    private enum FontNames: String{
        case ramche = "Ramche"
    }
    //1 declare
    let backgroundImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunny")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timeLabel = getRegularLabel(text: labelStrings[0], size: 16)
    
    let locationImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    let locationLabel = getRegularLabel(text: labelStrings[1], size: 20)
    let shareButton = getButton(iconName: "square.and.arrow.up")
    let refreshButton = getButton(iconName: "arrow.clockwise")
    
    let tempLabel = getLabel(text: labelStrings[2])
    let humidLabel = getLabel(text: labelStrings[3])
    let windLabel = getLabel(text: labelStrings[4])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "날씨"
        
        //2addview
        view.addSubview(backgroundImage)
        view.addSubview(timeLabel)
        
        view.addSubview(locationImage)
        view.addSubview(locationLabel)
        view.addSubview(shareButton)
        view.addSubview(refreshButton)
        
        view.addSubview(tempLabel)
        view.addSubview(humidLabel)
        view.addSubview(windLabel)

        
        //3layout
        configureConstraints()

    }
    

    
    
    private func configureConstraints(){
        let defaultOffset = 16
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(defaultOffset)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).offset(defaultOffset)
        }
        
        
        locationImage.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.leading)
            make.top.equalTo(timeLabel.snp.bottom).offset(defaultOffset)
            make.size.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationImage.snp.trailing).offset(defaultOffset)
            make.top.equalTo(locationImage.snp.top)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).offset(-defaultOffset)
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.size.equalTo(20)
        }
        shareButton.snp.makeConstraints { make in
            make.trailing.equalTo(refreshButton.snp.leading).offset(-defaultOffset)
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.size.equalTo(20)
        }
        
        //TODO: intrinsic size를 감안하여 패딩을 어떻게 주지? 패딩 뷰 위에 올린다고 해도 패딩 뷰의 사이즈는 라벨뷰에 의해 정해져야는데...
        tempLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.leading)
            make.top.equalTo(locationImage.snp.bottom).offset(defaultOffset)
            make.height.equalTo(24)
            make.width.equalTo(140)
        }
        humidLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.leading)
            make.top.equalTo(tempLabel.snp.bottom).offset(defaultOffset)
            make.height.equalTo(24)
            make.width.equalTo(160)
        }
        windLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.leading)
            make.top.equalTo(humidLabel.snp.bottom).offset(defaultOffset)
            make.height.equalTo(24)
            make.width.equalTo(200)
        }
        
    }
   
    private static func getLabel(text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.font = ramchefont(size: 20)
        label.textAlignment = .center

        return label
    }
    
    private static func getRegularLabel(text: String, size: CGFloat) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = ramchefont(size: size)
        label.textColor = .white
        return label
    }
    
    private static func getButton(iconName: String) -> UIButton{
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: iconName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }
    
    private static func ramchefont (size: CGFloat) -> UIFont{
        return UIFont(name: FontNames.ramche.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
