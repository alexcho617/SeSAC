//
//  CustomTableViewCell.swift
//  SeSACweek6
//
//  Created by Alex Cho on 2023/08/25.
//

import UIKit
import SnapKit
class CustomTableViewCell: UITableViewCell {
    
    let label = UILabel()
    let button = UIButton()
    
    //UITableViewCell에서 온 메소드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    //프로토콜 기반이기 때문에 UIView에서 요구하는 구문
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        contentView.addSubview(label)
        contentView.addSubview(button)
        label.backgroundColor = .yellow
        button.backgroundColor = .green
    }
    
    func setConstraints(){
        //leading and trailing은 margin을 사용
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView)
        }
        
        label.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
//
// //Interface Builder로 만들었을때 호출
// override func awakeFromNib() {
//     super.awakeFromNib()
//     // Initialization code
// }
