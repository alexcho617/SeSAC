//
//  VideoViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
struct Video{
    /*
     "datetime" : "2020-05-21T18:00:27.000+09:00",
     "thumbnail" : "https:\/\/search4.kakaocdn.net\/argon\/138x78_80_pr\/9OjsAGc91Po",
     "url" : "http:\/\/www.youtube.com\/watch?v=zq1_VzTeScE",
     "title" : "[IU TV] 아이유 분노의 쇼핑",
     "author" : "이지금 [IU Official]",
     "play_time" : 403
     */
    
    
    let date: String
    let thumb: String
    let author: String
    let playtime: Int
    let title: String
    let link: String
    
    var contents: String{
        get {
            return "\(author) | \(playtime) \n \(date)"
        }
    }
}
class VideoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var videoList: [Video] = []
    var page = 1
    var isEnd = false // 현재 페이지가 마지막인지 점검함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 140
//        callRequest(query: "아이유",page: page)
    }
    
    
    func callRequest(query: String, page: Int){
        //pagination
        let headers: HTTPHeaders = ["Authorization":APIKey.kakaoKey]
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let size = 10
        
        //스크롤 2/3 지점 혹은 4~개 정도의 데이터가 남아있을때: 마지막 셀이 나오기 전에
        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(text)&size=\(size)&page=\(page)"
        print(url)
        AF.request(url, method: .get, headers: headers).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let statusCode = response.response?.statusCode ?? 500
                if statusCode == 200{
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    for item in json["documents"].arrayValue{
                        let author = item["author"].stringValue
                        let date = item["datetime"].stringValue
                        let time = item["play_time"].intValue
                        let thumbnail = item["thumbnail"].stringValue
                        let title = item["title"].stringValue
                        let link = item["url"].stringValue
                        let data = Video(date: date, thumb: thumbnail, author: author, playtime: time, title: title, link: link)
                        self.videoList.append(data)
                    }
                    
                    print("JSON: \(json)")
//                    print(self.videoList)
                    self.tableView.reloadData()
                } else{
                    print(response.response?.statusCode)
                    print("Status code error")
                    //report to developer
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
//UITableViewDataSourcePrefetching: iOS10 이상 사용 가능. cellForRowAt 전에 미리 호출 됨 (디자인 전에 호출 되어서 데이터를 결정해준다는 뜻)
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{
    //셀이 화면에 보이기전에 미리 다운로드
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd{ //1.마지막 위치, 2.kakao의 경우 페이지 제한 15, 3.끝이 아니라면
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    //취소기능: 직접 기능 구현해야함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //프린트만 하고있지만 실제 다운로드가 되고있는경우 직접 취소해야함
        print("====Cancel: \(indexPaths)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? tableViewCell else {return UITableViewCell() }
        let row = videoList[indexPath.row]
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.contents
        cell.thumbnailImageView.kf.setImage(with:URL(string: row.thumb)) //고화질이면 prefetch 써야함
        return cell
    }
}

extension VideoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        videoList.removeAll()
        page = 1 //새로운 검색어
        guard let query = searchBar.text else { return }
        callRequest(query:query, page: page)
    }
}
