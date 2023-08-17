//
//  VideoViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Kingfisher


class VideoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResult: VideoSearch?
//    var searchResult: VideoSearch = VideoSearch(documents: [], meta: Meta(isEnd: false, pageableCount: 0, totalCount: 0))
    var page = 1
    var isEnd = false // 현재 페이지가 마지막인지 점검함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 140
    }
    
    
    func callRequest(query: String, page: Int){
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { [self] data in
            self.isEnd = data.meta.isEnd
            
            guard searchResult != nil else {
                self.searchResult = data
                self.tableView.reloadData()
                return
            }
            searchResult!.documents.append(contentsOf: data.documents)
            self.tableView.reloadData()
        }
    }
}

//UITableViewDataSourcePrefetching: iOS10 이상 사용 가능. cellForRowAt 전에 미리 호출 됨 (디자인 전에 호출 되어서 데이터를 결정해준다는 뜻)
extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{
    //셀이 화면에 보이기전에 미리 다운로드
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            if (searchResult?.documents.count ?? 1) - 1 == indexPath.row && page < 15 && !isEnd{ //1.마지막 위치, 2.kakao의 경우 페이지 제한 15, 3.끝이 아니라면
                page += 1
                print("Page:",page)
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    //취소기능: 직접 기능 구현해야함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        //프린트만 하고있지만 실제 다운로드가 되고있는경우 직접 취소해야함
        print("Cancel: \(indexPaths)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResult?.documents.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCell.identifier) as? tableViewCell else {return UITableViewCell() }
        
        if let row = searchResult?.documents[indexPath.row]{
            cell.titleLabel.text = row.title
            cell.contentLabel.text = row.author
            cell.thumbnailImageView.kf.setImage(with:URL(string: row.thumbnail)) //고화질이면 prefetch 써야함
        }
        
        
        return cell
    }
}

extension VideoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult?.documents.removeAll()
        page = 1 //새로운 검색어
        guard let query = searchBar.text else { return }
        callRequest(query:query, page: page)
    }
}
