//
//  TrendViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

class TrendViewController: UIViewController {
    private var trendResults: Trends?
    private var creditResultsDictionary: [Int:Credits] = [:]
    
    @IBOutlet weak var trendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendTableView.dataSource = self
        trendTableView.delegate = self
        configureView()
        callRequest()
    }
    
    private func configureView(){
        title = "Trending"
        let nib = UINib(nibName: TrendsTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendsTableViewCell.identifier)
        trendTableView.rowHeight = UITableView.automaticDimension
    }
    
    //High cost api - provide indicator view
    private func callRequest(){
        TmdbAPIManager.shared.callTrendsRequest(type: MediaType.movie, timeWindow: TimeWindow.week){ response in
            self.trendResults = response.value
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendsTableViewCell.identifier) as? TrendsTableViewCell else{
            print("Fail Loading Tableview Cell")
            return UITableViewCell()
        }
        cell.media = trendResults?.results[indexPath.row]
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        guard let trendResults else { return }
        vc.media = trendResults.results[indexPath.row]
        vc.credits = creditResultsDictionary[trendResults.results[indexPath.row].id]
        
        
        
        navigationController?.pushViewController(vc, animated: true)
        //        present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
