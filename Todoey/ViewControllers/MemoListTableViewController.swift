//
//  MemoListTableViewController.swift
//  Todoey
//
//  Created by 신소민 on 2021/10/29.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class MemoListTableViewController: UITableViewController {
    
    let itemIdentifier = "list item"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var memoArray = [Memo]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar settings
        navigationItem.title = "메모"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))

        // Search bar settings
        searchBar.delegate = self
        
        // Tableview settings
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
        tableView.tableHeaderView = searchBar
        
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
                        
            let newMemo = Memo(context: self.context)
            newMemo.content = textField.text!
            newMemo.isCheckmarked = false
            self.memoArray.append(newMemo)
            
            self.saveData()
        }
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Model Manipulate Methods
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Memo> = Memo.fetchRequest()) {
        do {
            memoArray = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
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
        memoArray[indexPath.row].isCheckmarked.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveData()
    }

}

// MARK: - Search bar method

extension MemoListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        request.predicate = NSPredicate(format: "content CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "content", ascending: true)]
        
        loadData(with: request)
    }
    
}
