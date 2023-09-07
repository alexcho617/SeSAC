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

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(PhotoListTableViewCell.self, forCellReuseIdentifier: PhotoListTableViewCell.reuseIdentifier)
        return view
    }()
    var tasks: Results<Diary>!
    let realm = try! Realm()
    let repository = DiaryTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tasks = realm.objects(Diary.self) //현재 정렬을 내부적으로 날짜 기준으로 하고있는데 명시적으로 정해줘야함.
        
        //제목순 정렬
        tasks = repository.fetch()
        print(tasks)
        repository.fileURL()
        repository.checkSchemaVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //이렇게 해도 데이터가 반영이 되고 있음
        //Realm내부에서 자동으로 최신 데이터를 유지함
        tableView.reloadData()
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let deleteButton = UIBarButtonItem(title: "초기화", style: .plain, target: self, action: #selector(deleteButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton, backupButton, deleteButton]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
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
        tableView.reloadData()
    }
    
    @objc func sortButtonClicked() {
        print(#function)
    }
    
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListTableViewCell.reuseIdentifier) as? PhotoListTableViewCell else {
            return UITableViewCell() }
        let data = tasks[indexPath.row]
        cell.titleLabel.text = data.title
        cell.contentLabel.text = data.contents
        cell.dateLabel.text = "\(data.date)"
        
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
        
        ///change this into file now.
        cell.diaryImageView.image = loadImagFromDocument(filename: "alex_\(data._id).jpg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tasks[indexPath.row]
        //전체 데이터 넘김
        let vc = DetailViewController()
        vc.diary = data //이 경우엔 데이터가 작기 떄문에 굳이 아이디만 넘겨서 디테일에서 다시 DB에서 가져올 필요가 없다
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let like = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            try! self.realm.write{
                self.tasks[indexPath.row].isLiked.toggle()
            }
            tableView.reloadData()
            
        }
        like.backgroundColor = .orange
        like.image = tasks[indexPath.row].isLiked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completionHandler in
            print("삭제 누름")
            let data = self.tasks[indexPath.row]

            //document imagefile 먼저 삭제
            self.removeImageFromDocument(filename: "alex_\(data._id).jpg")
            //realm 삭제
            try! self.realm.write{
                self.realm.delete(data)
            }
            tableView.reloadData()
        }
        delete.image = UIImage(systemName: "trash")
        let config = UISwipeActionsConfiguration(actions: [like, delete])
        return config
    }
}
