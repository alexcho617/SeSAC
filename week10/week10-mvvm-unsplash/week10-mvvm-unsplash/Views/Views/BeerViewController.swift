//
//  BeerViewController.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/21.
//

import UIKit
import Combine
import Kingfisher
import SnapKit

class BeerViewController: UIViewController {
    
    private let vm = BeerViewModel()
    private var cancelBag = Set<AnyCancellable>() //이건 정확히 왜 필요한건지 공부하기
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    let nameLabel = {
        let view = UILabel()
        view.text = "name"
        return view
    }()
    
    let idLabel = {
        let view = UILabel()
        view.text = "id"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        subscribe()
        vm.request()
    }

    //error handle 어떻게 하나?
    func subscribe(){
        vm.$beer
            .receive(on: DispatchQueue.main)
            .sink { beer in
                self.imageView.kf.setImage(with: URL(string: beer.first?.imageURL ?? ""))
                self.nameLabel.text = beer.first?.name ?? "name"
                self.idLabel.text = "\(beer.first?.id ?? -999)"
            }
            .store(in: &cancelBag)
    }
    
    func setView(){
        title = "Beer"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
    }
    
    func setConstraints(){
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
        idLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
}
