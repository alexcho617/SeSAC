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
    private var expandCast = false

    var media: Result?
    var credits: Credits?
    private let sectionInfo = ["Overview", "Cast"]
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerBackdrop: UIImageView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var headerRelatedButton: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var headerPoster: UIImageView!
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var footerMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        configureView()
    }
    
    @IBAction func footerMoreClicked(_ sender: UIButton) {
        expandCast.toggle()
        detailTableView.reloadData()
        footerMoreButton.setTitle(expandCast ? "Less" : "Show All...", for: .normal)

    }
    
    //go to related screen
    @IBAction func headerRelatedClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: RelatedViewController.identifier) as! RelatedViewController
        vc.mediaId = media?.id ?? 0
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func configureView(){
        title = media?.title
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
        
        //font 적용이 안되네...?
        footerMoreButton.setTitle(expandCast ? "Less" : "Show All...", for: .normal)
        
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1{
                expandOverview.toggle()
                let path = IndexPath(row: 0, section: 0)
                tableView.reloadRows(at: [path], with: .automatic)

            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionInfo[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }
        else{
            if expandCast == true{
                return credits!.cast.count
            }else{
                return 3
            }
            
        }
                
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //overview
        if indexPath.section == 0 {
            if indexPath.row == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {return UITableViewCell()}
                
                cell.overviewLabel.numberOfLines = expandOverview == true ? 0:2
                cell.overviewLabel.text = media?.overview
                return cell
            } else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreButtonTableViewCell.identifier) as? MoreButtonTableViewCell else {return UITableViewCell()}
                cell.titleLabel.text = expandOverview ? "Less" : "More..."
                return cell
            }
            
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
