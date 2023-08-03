//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by Alex Cho on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    //variables
    static var list = [
        "test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1","test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2","test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3"
    ]
      
    static func add(item: String){
        list.append(item)
        print(list)
        
    }
    
    //outlets
    
    
    //vdl
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        
        //register xib file views
        //xib becomes nib
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil)//main bundle if nil
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
        //Dynamic Height: 1.automaticDimension, 2.label numberOfLines 3.AutoLayout
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    //actions
    @IBAction func AddButtonClicked(_ sender: UIBarButtonItem) {
        //1. find storyboard file
//        let sb = UIStoryboard(name: "Main", bundle: nil) VC가 같은 파일에 있다면 필요 없음
        
        //2. find view cont. inside sb file
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else{
            return
        }
        
        vc.transitionType = .add
        //2-1(optional) with navigation controller
        let nc = UINavigationController(rootViewController: vc)
        
        //3. configure navigation
//        vc.modalTransitionStyle = .crossDissolve //partialCurl은 fullscreen 으로만 가능?
        vc.modalPresentationStyle = .fullScreen
        
        //3-1 with nc
        nc.modalPresentationStyle = .fullScreen
        
        //4. navigate
//        present(vc, animated: true) //similar to modal
        present(nc, animated: true)
        
    }
    
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchCollectionViewController")
//        let nc = UINavigationController(rootViewController: vc)
//        nc.modalPresentationStyle = .fullScreen
//        present(nc, animated: true)
//
        
        navigationController?.pushViewController(vc, animated: true)
    }
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DiaryTableViewController.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else{
            return UITableViewCell()
        }
        cell.contentLabel.text = DiaryTableViewController.list[indexPath.row]
        cell.backgroundColor = .clear
        //Dynamic Height
        cell.contentLabel.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. find storyboard file
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        //2. find view cont. inside sb file
//        let vc = DetailViewController() 이거는 파일만 가져오기때문에 Storyboard데이터를 가져오지 않는다. 코드베이스로만 작업할때 사용할것이다.
        guard let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else{
            print("cannot initiate detailviewcontroller")
            return
        }
//        vc.contentsLabel.text = list[indexPath.row] //Fatal error: Unexpectedly found nil while implicitly unwrapping an Optional value
        //contentsLabel is not made yet since its from IB
        
        
        vc.transitionType = .edit
//        ** 아웃렛 직접 설정 불가능 vc.contentsTextView.text = list[indexPath.row]
        vc.contents = DiaryTableViewController.list[indexPath.row]
        
        //make sure navigation controller is embedded entrypoint is set to it
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //editing rows
    //1 System swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //2 system swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DiaryTableViewController.list.remove(at: indexPath.row)
        tableView.reloadData()
        print(DiaryTableViewController.list)
    }
    
//    custom swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextMenuConfiguration(actionProvider: )
//        UISwipeActionsConfiguration(actions: [action])
//    }
//    custom swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    }
}
