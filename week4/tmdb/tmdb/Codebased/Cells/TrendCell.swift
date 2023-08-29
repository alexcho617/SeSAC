//
//  TrendsCell.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/29.
//

import UIKit

class TrendCell: BaseTableViewCell{
    var media: Result?
    var nf = NumberFormatter()

    let date = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .secondaryLabel
        return view
    }()
    
    let title = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "test text"
        return view
    }()
    
    let genre = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 17)
        return view
    }()
    
    let backdrop = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .blue
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] //상단 좌우만 커브
        view.layer.masksToBounds = true
        return view
    }()
    
    let rating = {
        let view = UILabel()
        return view
    }()
    
    let original = {
        let view = UILabel()
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        view.text = "test text"
        return view
    }()
    
    let information = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .secondaryLabel
//        TODO: 이걸 0 으로 만들고 Tableview에서 auto dimension 적용 해보기
        view.numberOfLines = 2
        return view
    }()
    

    func assignDataToView(){
        if let media{
            //TODO: Genre abstraction 필요
            var genreString = ""
            for id in media.genreIDS{
                genreString += "#\(Genre.genreDictionary[id]!) "
            }
            date.text = media.releaseDate
            genre.text = genreString
            title.text = media.title
            backdrop.kf.setImage(with: URL.getEndPointImageURL(media.backdropPath))
            original.text = media.originalTitle
            information.text = media.overview
        }
    }
    
    override func setView() {
        addSubview(date)
        addSubview(title)
        addSubview(genre)
        addSubview(backdrop)
        addSubview(rating)
        addSubview(original)
        addSubview(information)
    }
    
    override func setConstraints() {
        
        date.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        genre.snp.makeConstraints { make in
            make.top.equalTo(date.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        backdrop.snp.makeConstraints { make in
            make.top.equalTo(genre.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(self).multipliedBy(0.65)
        }
        
        //타이틀 공간 우선 확보
        title.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        title.snp.makeConstraints { make in
            make.top.equalTo(backdrop.snp.bottom)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        original.snp.makeConstraints { make in
            make.top.equalTo(backdrop.snp.bottom)
            make.leading.equalTo(title.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        information.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
