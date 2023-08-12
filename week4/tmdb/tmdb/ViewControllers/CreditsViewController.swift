//
//  CreditsViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("calling credits")
        TmdbAPIManager.shared.callCreditsRequest(of: 569094)

    }
}
