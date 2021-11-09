//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class FolderGridViewController: UICollectionViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var folderArray = [Folder]()
    
    private lazy var addButton: UIButton = {
        
        let addButton = UIButton()
        addButton.tintColor = .black
        addButton.backgroundColor = .white
        addButton.layer.borderWidth = 0.5
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 25
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        let plusImage = UIImage.init(systemName: "plus")?.applyingSymbolConfiguration(.init(weight: .bold))
        addButton.setImage(plusImage, for: .normal)
        addButton.contentHorizontalAlignment = .fill
        addButton.contentVerticalAlignment = .fill
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return addButton
    }()
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            return NSCollectionLayoutSection.responsiveGridSection(env: env)
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar settings
        navigationItem.title = "Todoey"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [editButtonItem]
        
        // CollectionView settings
        collectionView.contentInset.top = 10
        collectionView.register(FolderCell.self, forCellWithReuseIdentifier: FolderCell.identifier)
    
        // Add Button settings
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Load data
        loadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if #available(iOS 14.0, *) {
            collectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
            // Fallback on earlier versions
        }
        
        showHideButtons(editing)
        collectionView.reloadData()
    }
    
    @objc func addButtonPressed() {
        
        var textField: UITextField!
        
        let alert = UIAlertController(title: "Add New Folder", message: nil, preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Folder name"
            textField = alertTextField
        }

        let addAction = UIAlertAction(title: "Add", style: .default) { [unowned self] action in
            let newFolder = Folder(context: self.context)
            newFolder.name = textField.text
            self.folderArray.append(newFolder)
            
            self.saveData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func removeButtonPressed() {
        
        collectionView.indexPathsForSelectedItems?.forEach({ indexPath in
            context.delete(folderArray[indexPath.row])
        })
        
        collectionView.indexPathsForSelectedItems?.reversed().forEach({ indexPath in
            folderArray.remove(at: indexPath.row)
        })

        saveData()
    }
    
    private func showHideButtons(_ editing: Bool) {
        if editing {
            // 'Add button' (hide animation)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.addButton.alpha = 0
            })
            
            // Append the 'Remove button'
            let removeButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeButtonPressed))
            navigationItem.rightBarButtonItems?.append(removeButtonItem)
            
        } else {
            // 'Add button' (show animation)
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.addButton.alpha = 1
            })
            
            // Pop the 'Remove button'
            if navigationItem.rightBarButtonItems?.count == 2 {
                _ = navigationItem.rightBarButtonItems?.popLast()
            }
        }
    }
    
    // MARK: - Data Manipulate Methods
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        collectionView.reloadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        do {
            folderArray = try context.fetch(request)
        } catch {
            print(error)
        }
        collectionView.reloadData()
    }
    
    // MARK: - Collection view data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        folderArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.identifier, for: indexPath) as? FolderCell else {
            fatalError()
        }
        cell.configureLabel(text: folderArray[indexPath.row].name!)
        cell.isEditing = isEditing
        return cell
    }
    
    // MARK: - Collection view delegate method
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            let memoVC = MemoListTableViewController()
            memoVC.selectedFolder = folderArray[indexPath.row]
            
            navigationController?.pushViewController(memoVC, animated: true)
        }
    }
    
}

