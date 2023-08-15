//
//  CreditsViewController.swift
//  tmdb
//
//  Created by Alex Cho on 2023/08/12.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private var expandOverview = false
    var media: Result?
    var credits: Credits?
    private let sectionInfo = ["Overview", "Cast"]
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerBackdrop: UIImageView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var headerPoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        configureView()
    }
    
    private func configureView(){
        title = "detailview"
        let nib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: CastTableViewCell.identifier)
        detailTableView.rowHeight = UITableView.automaticDimension
        
        //header
        headerBackdrop.contentMode = .scaleAspectFill
        headerBackdrop.kf.setImage(with: URL.getEndPointImageURL(media?.backdropPath ?? ""))
        
        filterView.alpha = 0.1
        
        headerTitle.text = media?.title
        headerTitle.textColor = .white
        
        headerPoster.contentMode = .scaleAspectFill
        headerPoster.kf.setImage(with: URL.getEndPointImageURL(media?.posterPath ?? ""))

    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            expandOverview.toggle()
        }
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionInfo[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
//            return credits!.cast.count
            return 20
        }
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //overview
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {return UITableViewCell()}
            
            cell.overviewLabel.numberOfLines = expandOverview == true ? 0:2
            cell.overviewLabel.text = media?.overview
            return cell
        }
        //casts
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else {return UITableViewCell()}
            if let row = credits?.cast[indexPath.row]{
                cell.profileImage.kf.setImage(with: URL.getEndPointImageURL(row.profilePath ?? ""))
                cell.nameLabel.text = row.name
                cell.infoLabel.text = row.character
            }
            
            return cell
        }
    }
    
    
}
