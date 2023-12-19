//
//  ViewController.swift
//  SwiftConcurrency
//
//  Created by Alex Cho on 12/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var posterImageView2: UIImageView!
    
    @IBOutlet weak var posterImageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            let images = try await Network.shared.fetchThumbnailTaskGroup()
            posterImageView.image = images[0]
            posterImageView2.image = images[1]
            posterImageView3.image = images[2]
        }
        
//        Task{
//            let images = try await Network.shared.fetchThumbnailAsyncLet()
//            posterImageView.image = images[0]
//            posterImageView2.image = images[1]
//            posterImageView3.image = images[2]
//            
//        }
//        print("1")
//        //비동기
//        Task{ //순서대로 실행: FCFS으로 되기 때문에 콘보이 현상 발생 문제
//            
//            /*
//             sfs4U6XpiKFngbbSzrpZbkM1ySI.jpg
//             anwNl1xbzXoj5Ax1nVw3WoDzHlw.jpg
//             8YaP48tVfngbURGldWk1I5odsBK.jpg
//             */
//            let stone = "8YaP48tVfngbURGldWk1I5odsBK.jpg"
//            let chamber = "sfs4U6XpiKFngbbSzrpZbkM1ySI.jpg"
//            let prisoner = "anwNl1xbzXoj5Ax1nVw3WoDzHlw.jpg"
//            print("2")
//            async let image = try await Network.shared.fetchThumbnailAsyncAwait(path: stone)
//            posterImageView.image = try await image
//            print("3")
//            let image2 = try await Network.shared.fetchThumbnailAsyncAwait(path: chamber)
//            posterImageView2.image = image2
//            print("4")
//            let image3 = try await Network.shared.fetchThumbnailAsyncAwait(path: prisoner)
//            posterImageView3.image = image3
//            print("5")
//
//        }
//        print("6")
        
//        Task{
//            await fetchImage()
//        }
//        
        
        
        //        Network.shared.fethThumbnil { [weak self] image in
        //            guard let self else {return}
        //            self.posterImageView.image = image
        //        }
        
        //        Network.shared.fetchWithURLSession { result in
        //
        //            switch result {
        //            case .success(let image):
        //                DispatchQueue.main.async { [self] in
        //                    posterImageView.image = image
        //                }
        //
        //            case .failure(let error):
        //                DispatchQueue.main.async { [self] in
        //                    posterImageView.backgroundColor = .blue
        //                }
        //
        //                print(error)
        //            }
        //        }
        
        
        
    }
    
//    @MainActor
//    func fetchImage() async{
//        do {
//            let image = try await Network.shared.fetchThumbnailAsyncAwait(path: "")
//            posterImageView.image = image
//        } catch {
//            print(error)
//        }
//    }
//    
}

