//
//  PhotoViewController.swift
//  unsplash-mvvm
//
//  Created by Alex Cho on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    let vm = PhotoViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        vm.fetchPhoto()
        vm.list.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    

}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photocell")!
        
        let data = vm.cellForRowAt(indexPath)
        cell.textLabel?.text = data.id
        cell.backgroundColor = .lightGray
        return cell
    }
    
    
}
