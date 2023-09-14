//
//  HomeViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import SnapKit
import RealmSwift
import Kingfisher

final class HomeViewController: BaseViewController {
    private func layout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
//    var cellRegi: UICollectionView.CellRegistration<UICollectionViewListCell,Diary>!
    var cellRegi: UICollectionView.CellRegistration<SearchCollectionViewCell,Diary>!
    
    //MARK: Change to Collectionview
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var tasks: Results<Diary>!
    let realm = try! Realm()
    let repository = DiaryTableRepository()
    
    
//    lazy var tableView: UITableView = {
//        let view = UITableView()
//        view.backgroundColor = .black
//        view.rowHeight = 100
//        view.delegate = self
//        view.dataSource = self
//        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = repository.fetch()
        repository.fileURL()
        repository.checkSchemaVersion()
        
        
        //MARK: Collectionview register
//
//        cell.titleLabel.text = data.title
//        cell.contentLabel.text = data.contents
//        cell.dateLabel.text = "\(data.date)"
//        cell.diaryImageView.image = loadImagFromDocument(filename: "alex_\(data._id).jpg")
        
        cellRegi = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            //system cell 쓸 떄만 쓰는건가? ㄴㄴ 그건 아닌데 closure안에서 dispatch queue 를 쓰려니까 안되는것 같음,
            
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.contents
            content.image = UIImage(systemName: "star")
           
//            let url = URL(string: itemIdentifier.photo!)!
//            print("DEBUG:",url)
            
//            let data = try! Data(contentsOf: url)
//            print("DEBUG:",data)
//            let image = UIImage(data: data)
//            print("DEBUG:",image)
            content.image = UIImage(named: "image")
            cell.contentConfiguration = content


//            cell.titleLabel.text = itemIdentifier.title
//            cell.imageView.kf.setImage(with: URL(string: itemIdentifier.photo!))
//
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = UIColor.systemMint
            cell.backgroundConfiguration = background
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func configure() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let deleteButton = UIBarButtonItem(title: "초기화", style: .plain, target: self, action: #selector(deleteButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton, deleteButton]
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = tasks[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegi, for: indexPath, item: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension HomeViewController{
    @objc func plusButtonClicked() {
        navigationController?.pushViewController(AddViewController(), animated: true)
    }
    
    @objc func backupButtonClicked() {
        let vc = BackupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteButtonClicked() {
        print(#function)
        let records = realm.objects(Diary.self)
        records.forEach { record in
            removeImageFromDocument(filename: "alex_\(record._id).jpg")
        }
        try! realm.write{
            realm.deleteAll()
        }
        collectionView.reloadData()
    }
    
    @objc func sortButtonClicked() {
        print(#function)
    }
    
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
        collectionView.reloadData()
    }
}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else {
//            return UITableViewCell() }
//        let data = tasks[indexPath.row]
//        cell.titleLabel.text = data.title
//        cell.contentLabel.text = data.contents
//        cell.dateLabel.text = "\(data.date)"
//        ///change this into file now.
//        cell.diaryImageView.image = loadImagFromDocument(filename: "alex_\(data._id).jpg")
//        return cell
//    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let data = tasks[indexPath.row]
    //        //전체 데이터 넘김
    //        let vc = DetailViewController()
    //        vc.diary = data //이 경우엔 데이터가 작기 떄문에 굳이 아이디만 넘겨서 디테일에서 다시 DB에서 가져올 필요가 없다
    //        navigationController?.pushViewController(vc, animated: true)
    //
    //    }
    
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let like = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
    //            try! self.realm.write{
    //                self.tasks[indexPath.row].isLiked.toggle()
    //            }
    //            tableView.reloadData()
    //
    //        }
    //        like.backgroundColor = .orange
    //        like.image = tasks[indexPath.row].isLiked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    //
    //        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completionHandler in
    //            print("삭제 누름")
    //            let data = self.tasks[indexPath.row]
    //
    //            //document imagefile 먼저 삭제
    //            self.removeImageFromDocument(filename: "alex_\(data._id).jpg")
    //            //realm 삭제
    //            try! self.realm.write{
    //                self.realm.delete(data)
    //            }
    //            tableView.reloadData()
    //        }
    //        delete.image = UIImage(systemName: "trash")
    //        let config = UISwipeActionsConfiguration(actions: [like, delete])
    //        return config
    //    }
    

    
    
//}//HomeViewController











//let urlString = data.PhotoURL ?? ""

///        kf 로 하는게 스크롤이 훨씬 잘 되고있음
//        cell.diaryImageView.kf.setImage(with: URL(string:data.PhotoURL ?? ""))
//접두어 + primary key를 사용해서 파일 이름을 저장한 상태


///        URLSession
//string -> url -> data -> UIImage
//1. if cell's data is large, load can take time
//2. change url into uiimage and present in the cell right away. can also cause problems in reusable mechanism. -> use prepareForReuse in the cell file
//        DispatchQueue.global().async {
//            if let url = URL(string: urlString), let data = try? Data(contentsOf: url){
//                DispatchQueue.main.async {
//                    cell.diaryImageView.image = UIImage(data: data)
//                }
//            }
//        }
