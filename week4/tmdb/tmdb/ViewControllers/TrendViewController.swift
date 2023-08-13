//
//  TrendViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

class TrendViewController: UIViewController {
    var movieList: [Media] = []
    @IBOutlet weak var trendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        trendTableView.dataSource = self
        trendTableView.delegate = self
        let nib = UINib(nibName: TrendsTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendsTableViewCell.identifier)
        trendTableView.rowHeight = 300
        
        callRequest()
    }
    
    func callRequest(){
        TmdbAPIManager.shared.callTrendsRequest(type: MediaType.movie, timeWindow: TimeWindow.week){ json in
            for item in json["results"].arrayValue{
                let media = Media(release_date: item["release_date"].stringValue, vote_average: item["vote_average"].floatValue, title: item["title"].stringValue, overview: item["overview"].stringValue, id: item["id"].intValue, poster_path: item["poster_path"].stringValue, backdrop_path: item["backdrop_path"].stringValue)
                self.movieList.append(media)
            }
            self.trendTableView.reloadData()
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendsTableViewCell.identifier) as? TrendsTableViewCell else{
            print("Fail Loading Tableview Cell")
            return UITableViewCell()
        }
        cell.media = movieList[indexPath.row]
        cell.configureView()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: CreditsViewController.identifier) as? CreditsViewController else { return}
        vc.mediaId = movieList[indexPath.row].id
        present(vc, animated: true)
        
    }
}
