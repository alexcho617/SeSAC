//
//  ViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/07.
//

import UIKit
import SwiftyJSON
import Alamofire

struct Movie{
    var title: String
    var release: String
    var count: String
}

class ViewController: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 70
        callRequest()
        
    }
    
    func callRequest(){
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=20230807"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue{
                    self.movieList.append(Movie(title: item["movieNm"].stringValue, release: item["openDt"].stringValue, count: item["audiAcc"].stringValue))
                }
                self.movieTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.detailTextLabel?.text = "\(indexPath.row + 1)위 \(movieList[indexPath.row].release) \(movieList[indexPath.row].count)명"
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
    
}
