//
//  MemoListTableViewController.swift
//  Todoey
//
//  Created by 신소민 on 2021/10/29.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    let itemIdentifier = "list item"
    var itemArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar settings
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        // Tableview settings
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
        
        // Load data
        if let items = UserDefaults.standard.stringArray(forKey: "memo array") {
            itemArray = items
        }
    }
    
    // MARK: - Methods
    
    @objc func addButtonPressed() {
        var textField: UITextField!
        
        let alert = UIAlertController(title: "메모 작성하기", message: nil, preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "메모를 작성하세요"
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { action in
            let memo = textField.text!
            self.itemArray.append(memo)
            self.tableView.reloadData()
            UserDefaults.standard.set(self.itemArray, forKey: "memo array")
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier, for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = itemArray[indexPath.row]
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = itemArray[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = (cell?.accessoryType == UITableViewCell.AccessoryType.none) ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
