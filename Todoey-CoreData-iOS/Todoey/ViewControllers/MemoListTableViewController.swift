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
    
    var selectedFolder: Folder! {
        didSet {
            loadData()
        }
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar settings
        navigationItem.title = selectedFolder.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))

        // Search bar settings
        searchBar.delegate = self
        
        // Tableview settings
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
        tableView.tableHeaderView = searchBar
    }
    
    @objc func addButtonPressed() {
        
        var textField: UITextField!
        
        let alert = UIAlertController(title: "Add New Memo", message: nil, preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Memo"
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [unowned self] action in
            let newMemo = Memo(context: self.context)
            newMemo.content = textField.text!
            newMemo.isCheckmarked = false
            newMemo.parentFolder = self.selectedFolder
            self.memoArray.append(newMemo)
            
            self.saveData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
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
    
    func loadData(with request: NSFetchRequest<Memo> = Memo.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let folderPredicate = NSPredicate(format: "parentFolder.name MATCHES %@", selectedFolder.name!)
        
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [folderPredicate, additionalPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = folderPredicate
        }
        
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
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            let request: NSFetchRequest<Memo> = Memo.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "content", ascending: true)]
            
            let searchPredicate = NSPredicate(format: "content CONTAINS[cd] %@", searchText)
            loadData(with: request, predicate: searchPredicate)
        }
    }
    
}
