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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    var memoArray: [Memo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar settings
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        // Tableview settings
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
        
        // Load data
        loadData()
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
            let text = textField.text!
            self.memoArray.append(Memo(content: text, isCheckmarked: false))
            self.tableView.reloadData()
            self.saveData()
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Model Manipulate Methods
    
    func saveData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(memoArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding memo array")
        }
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                memoArray = try decoder.decode([Memo].self, from: data)
            } catch {
                print("Error decoding memo array")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier, for: indexPath)
        let memo = memoArray[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = memoArray[indexPath.row].content
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = memoArray[indexPath.row].content
        }
        
        cell.accessoryType = memo.isCheckmarked ? .checkmark : .none
        return cell
    }
    
    // MARK: - Table view delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let memo = memoArray[indexPath.row]
        
        cell?.accessoryType = memo.isCheckmarked ? .none : .checkmark
        memoArray[indexPath.row].isCheckmarked.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData()
    }

}
