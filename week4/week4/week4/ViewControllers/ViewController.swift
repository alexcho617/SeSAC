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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieList: [Movie] = []
    var result: MovieBoxOffice?

    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchBar.delegate = self
        movieTableView.rowHeight = 70
        indicator.isHidden = true
        
    }
    
    func callRequest(date: String){
        
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        AF.request(url, method: .get).validate().responseDecodable(of: MovieBoxOffice.self) { response in
            
            self.result = response.value
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.movieTableView.reloadData()
        }
       
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieList.removeAll()
        callRequest(date: searchBar.text!)
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return result?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        if let result{
            let row = result.boxOfficeResult.dailyBoxOfficeList[indexPath.row]
            cell.textLabel?.text = row.movieNm
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.detailTextLabel?.text = "\(indexPath.row + 1)위 \(row.openDt) \(row.audiAcc)명"
        }
       
        return cell
    }
    
}

//responseJSON old
//    func callRequest(date: String){
//        self.indicator.isHidden = false
//        self.indicator.startAnimating()
//        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print(json)
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue{
//                    self.movieList.append(Movie(title: item["movieNm"].stringValue, release: item["openDt"].stringValue, count: item["audiAcc"].stringValue))
//                }
//                self.indicator.stopAnimating()
//                self.indicator.isHidden = true
//                self.movieTableView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
