//
//  TrendViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

class TrendViewController: UIViewController {
    private var trendResult: Trends?
    
    @IBOutlet weak var trendTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        trendTableView.dataSource = self
        trendTableView.delegate = self
        configureView()
        callRequest()
    }
    
    private func configureView(){
        let nib = UINib(nibName: TrendsTableViewCell.identifier, bundle: nil)
        trendTableView.register(nib, forCellReuseIdentifier: TrendsTableViewCell.identifier)
        trendTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func callRequest(){
        TmdbAPIManager.shared.callTrendsRequest(type: MediaType.movie, timeWindow: TimeWindow.week){ response in
            self.trendResult = response.value
            self.trendTableView.reloadData()
        }
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let trendResult{
            return trendResult.results.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendsTableViewCell.identifier) as? TrendsTableViewCell else{
            print("Fail Loading Tableview Cell")
            return UITableViewCell()
        }
        cell.media = trendResult?.results[indexPath.row]
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: CreditsViewController.identifier) as? CreditsViewController else { return }
        vc.mediaId = trendResult?.results[indexPath.row].id
        present(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
