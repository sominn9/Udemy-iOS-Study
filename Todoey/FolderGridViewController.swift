//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class FolderGridViewController: UICollectionViewController {
    
    let itemIdentifier = "item cell"
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env) in
            return NSCollectionLayoutSection.responsiveGridSection(env: env)
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Todoey"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: itemIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }

}

