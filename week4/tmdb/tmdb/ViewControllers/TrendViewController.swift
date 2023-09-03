//
//  TrendViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit
import TMDBHelperFramework

class TrendViewController: UIViewController {
    private var trendResults: Trends?
    private var creditResultsDictionary: [Int:Credits] = [:]
    
    @IBOutlet weak var trendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendTableView.dataSource = self
        trendTableView.delegate = self
        trendTableView.register(TrendCell.self, forCellReuseIdentifier: TrendCell.identifier)
        configureView()
//        callRequest()
        callRequestWithURLSession()
        trendTableView.rowHeight = UIScreen.main.bounds.height * 0.4
    }
    
    private func configureView(){
        title = "Trending"
        let nib = UINib(nibName: TrendsTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendsTableViewCell.identifier)
    }
    
    //DispatchGroup 사용 가능
    //High cost api - provide indicator view
    private func callRequest(){
        TmdbAPIManager.shared.callTrendsRequest(type: MediaType.movie, timeWindow: TimeWindow.week){ response in
            self.trendResults = response.value
            if let err = response.error{
                
                print(err)
                
                self.showAlert(title: "삐빅!", message: "네트워크 이슈 같아요", buttonTitle: "돌아가기")
            }
            if self.trendResults != nil{
                for result in self.trendResults!.results{
                    TmdbAPIManager.shared.callCreditsRequest(of: result.id){response in
                        self.creditResultsDictionary[result.id] = response.value
                    }
                }
            }
            self.trendTableView.reloadData()
            
        }
    }
    
    private func callRequestWithURLSession(){
        TmdbAPIManager.shared.callTrendsRequestWithURLSession(type: MediaType.movie, timeWindow: TimeWindow.week) { response in
            
            self.trendResults = response
            if self.trendResults != nil{
                for result in self.trendResults!.results{
                    TmdbAPIManager.shared.callCreditsRequest(of: result.id){response in
                        self.creditResultsDictionary[result.id] = response.value
                    }
                }
            }
            DispatchQueue.main.async {
                self.trendTableView.reloadData()
            }
            
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trendResults{
            return trendResults.results.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendCell.identifier) as? TrendCell else{
            print("Fail Loading Tableview Cell")
            return UITableViewCell()
        }
        cell.media = trendResults?.results[indexPath.row]
        cell.assignDataToView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        guard let trendResults else { return }
        vc.media = trendResults.results[indexPath.row]
        vc.credits = creditResultsDictionary[trendResults.results[indexPath.row].id]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
