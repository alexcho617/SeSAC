//
//  MovieTableViewCell.swift
//  MovieTable
//
//  Created by Alex Cho on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = "MovieTableViewCell"
    
    func configureCell(_ movie: Movie){
        movieImageView.image = UIImage(named: movie.title)
        titleLabel.text = movie.title
        infoLabel.text = "\(movie.releaseDate) | \(movie.runtime)분 | \(movie.rate)점"
        descriptionLabel.text = movie.overview
    }
}
