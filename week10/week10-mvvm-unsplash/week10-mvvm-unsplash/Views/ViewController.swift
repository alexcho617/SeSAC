//
//  ViewController.swift
//  week10-mvvm-unsplash
//
//  Created by Alex Cho on 2023/09/19.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import Combine

class ViewController: UIViewController{
    private lazy var scrollView = {
        let view = UIScrollView()
        view.delegate = self
        view.backgroundColor = .lightGray
        //MARK: Zoom 1x ~ 4x
        view.minimumZoomScale = 0.5
        view.maximumZoomScale = 4
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        imageView.isUserInteractionEnabled = true
        
        return view
    }()
    
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let vm = ViewModel()
    private var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayout()
        setGesture()
        
        setUpViewModel()
        vm.request()//fetch
        
    }
    
    //add observer
    func setUpViewModel(){
        vm.$urlString
            .receive(on: DispatchQueue.main)
            .sink { urlString in
                print("ViewController-setUpViewModel: urlString \(urlString)")
                self.imageView.kf.setImage(with: URL(string: urlString))
            }
            .store(in: &cancelBag)
        
    }
    
    private func setGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2 //Double Tap
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture(){
        //zoom in and out
        print(#function)
        if scrollView.zoomScale == 1{
            scrollView.setZoomScale(2, animated: true)
        } else{
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    private func setView(){
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func setLayout(){
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalTo(view)
        }
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
}

extension ViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}












//        Network.shared.request(type: PhotoResult.self, api: .detail(id: "TkWustNCN5A")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//        Network.shared.request(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//        Network.shared.request(type: Photo.self, api: .search(query: "sky")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }


//Result<> 쓰지 않았기 때문에 Optional check 해야함
//        NetworkBasic.shared.random { photo, error in
//            guard let photo = photo else {return} //early exit 해버리면 에러는?
//            guard let error = error else {return} //error not nil but exited
//        }

//Result를 썼기 때문에 response라는 하나의 값만 들어옴
//        NetworkBasic.shared.detailPhoto(id: "") { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                dump(failure)
//            }
//        }
