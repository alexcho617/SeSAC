//
//  HomeViewController.swift
//  Bookwarm
//
//  Created by Alex Cho on 2023/09/04.
//

import UIKit
import RealmSwift
import SnapKit

class HomeViewController: UIViewController {

    var books: Results<RealmBook>!
    let deleteButton = {
        let view = UIButton()
        view.setTitle("전체 삭제", for: .normal)
        view.backgroundColor = .red
        return view
        
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return view
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        books = BookRealmRepository.shared.read()
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BookRealmRepository.shared.getFileURL()
        BookRealmRepository.shared.checkSchemaVersion()

        
        view.addSubview(deleteButton)
        view.addSubview(tableView)
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        deleteButton.addTarget(self, action: #selector(deleteRealm), for: .touchUpInside)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func deleteRealm(){
        //delete file
        for book in books{
            deleteFileFromDocument(filename: "\(book._id.stringValue).jpeg")
            BookRealmRepository.shared.delete(book)
        }
        
        tableView.reloadData()
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell()}
        
        let data = books[indexPath.row]
        cell.setView()
        cell.titleLabel.text = data.title
        cell.coverImageView.kf.setImage(with: URL(string: data.thumbnailImageURL))
        cell.infoLabel.text = data.memo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let vc = BookDetailViewController()
        vc.book = books[indexPath.row]
//        present(vc,animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //TODO: AddTrailingSwipeAction
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//    }
}
