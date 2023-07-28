//
//  MovieTableViewController.swift
//  MovieTable
//
//  Created by Alex Cho on 2023/07/28.
//

import UIKit

class MovieTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 200

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieInfo.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else{
            return UITableViewCell()
        }
        
        let row = indexPath.row
        cell.configureCell(MovieInfo.movie[row])
        return cell
    }

}
