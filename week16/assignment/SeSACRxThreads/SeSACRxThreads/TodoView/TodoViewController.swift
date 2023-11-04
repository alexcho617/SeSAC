//
//  TodoViewController.swift
//  SeSACRxThreads_Asgnmt
//
//  Created by Alex Cho on 2023/11/04.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TodoViewController: UIViewController {

    //views
    private let addTextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실 건가요?"
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private let addButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.backgroundColor = .systemGray2
        return view
    }()
    private let tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .systemGray2
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    let searchBar = UISearchBar()
    
    let vm = TodoViewModel()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
        bind()
    }
    
    func setView(){
        title = "쇼핑"
        view.backgroundColor = .systemBackground
        view.addSubview(addTextField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        tableView.delegate = self
        
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
    }
    
    func setConstraints(){
        addTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(addButton.snp.leading).offset(-8)
            make.height.equalTo(60)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addTextField.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
    func bind(){
        
        //textfield <-> title
        addTextField.rx.text.orEmpty
            .bind(to: vm.todoTitle)
            .disposed(by: bag)
        
        //button action
        addButton.rx.tap
            .subscribe(with: self) { owner, _ in
                //이거를 그냥 vm에서 value()같은걸로 할 순 없을까?
                if let title = owner.addTextField.text, !title.isEmpty{
                    owner.vm.addTodo(title: title)
                    owner.addTextField.text = ""
                }
            }.disposed(by: bag)
        
        //cell for row at
        vm.todoItems.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){ row, element, cell in
            cell.textLabel?.text = element.title
            
        }.disposed(by: bag)
        
        //didselect row at
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(TodoModel.self))
            .map{"\($0), \($1.title)"}
            .subscribe(with: self) { owner, value in
                print(value)
                let vc = SampleVC()
                vc.title = value
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: bag)
       
        
        //search
        searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(with: self) { owner, value in
                let result = value == "" ? owner.vm.todoData : owner.vm.todoData.filter { $0.title.contains(value) }
                owner.vm.todoItems.onNext(result)
            }.disposed(by: bag)

    }
}


extension TodoViewController: UITableViewDelegate{
    //index기반이 아니라 rxdatasource 방식으로 바꿔야할듯. tableview.rx.itemDeleted 사용해보기
    //https://ios-development.tistory.com/1015
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { _, _, handler in
            self.vm.todoData.remove(at: indexPath.row)
            self.vm.todoItems.onNext(self.vm.todoData)
            handler(true)
        }
        let action = UISwipeActionsConfiguration(actions: [delete])
        return action
    }
}



