//
//  TrendViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

class TrendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("calling trends")
        TmdbAPIManager.shared.callTrendsRequest(type: Media.movie, timeWindow: TimeWindow.week)
    }
}
