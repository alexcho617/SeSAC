//
//  ThirdTableViewController.swift
//  tableView
//
//  Created by Alex Cho on 2023/07/27.
//

import UIKit



class ThirdTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let shoppingCell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell") else {
            print("no cell found")
            return UITableViewCell()
        }
        
        //Dynamic 으로 했는데 그러면 스토리보드를 UIViewController로 연결 후 subview에 Tableview를 넣고 그 tableview를 코드로 제어를 어떻게 해야하지..?
        //image, contentview와 같은 것들은 getter 밖에 없다
        return shoppingCell
    }
    
    
}

