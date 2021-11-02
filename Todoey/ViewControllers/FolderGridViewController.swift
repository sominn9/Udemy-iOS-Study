//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class FolderGridViewController: UICollectionViewController {
    
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
        navigationItem.title = "Todoey"
        navigationItem.rightBarButtonItem = editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.contentInset.top = 10
        collectionView.register(FolderCell.self, forCellWithReuseIdentifier: FolderCell.identifier)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if #available(iOS 14.0, *) {
            collectionView.allowsMultipleSelectionDuringEditing = editing
        } else {
            // Fallback on earlier versions
        }
        
        collectionView.reloadData()
    }
    
    // MARK: - Collection view data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    // MARK: - Collection view delegate method
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.identifier, for: indexPath) as? FolderCell else {
            fatalError()
        }
        cell.configureLabel(text: "\(indexPath.row)번째 폴더")
        cell.isEditing = isEditing
        return cell
    }
    
}

