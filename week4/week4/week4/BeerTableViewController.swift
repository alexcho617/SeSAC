//
//  BeerTableViewController.swift
//  week4
//
//  Created by Alex Cho on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
class BeerTableViewController: UITableViewController {
    let limit = 5
    var beerList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestCall()
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath)
        cell.textLabel?.text = beerList[indexPath.row]
        return cell
    }
    
    func requestCall(){
        let url = "https://api.punkapi.com/v2/beers?per_page=\(limit)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json.arrayValue{
                    self.beerList.append(item["name"].stringValue)
                }
                print(self.beerList)
                self.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
}
