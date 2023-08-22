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
    let greetingLabel = getLabel(text: labelStrings[5])
    
    lazy var weatherStackView = { [self] in //capture self 는 뭘까?
        let stackView = UIStackView(arrangedSubviews: [tempLabel,humidLabel,windLabel,greetingLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
        
    }()
    

    
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
        
        view.addSubview(weatherStackView)

        
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
        
        weatherStackView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.leading)
            make.top.equalTo(locationImage.snp.bottom).offset(defaultOffset)
        }
        
    }
   
    private static func getLabel(text: String) -> UILabel{
        let label = BasePaddingLabel()
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

//https://ios-development.tistory.com/698
fileprivate class BasePaddingLabel: UILabel { //uilabel 상속
    private var padding = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0) //이걸 밖으로 빼고싶은데 쉽지 않네

    //이건 또 뭐야...?
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
