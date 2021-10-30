//
//  FolderCell.swift
//  Todoey
//
//  Created by 신소민 on 2021/10/30.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class FolderCell: UICollectionViewCell {
    
    static let identifier = "FolderCell"
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Label settings
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        // Background settings
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure Methods
    
    func configureLabel(text: String) {
        label.text = text
    }
    
    func configureBackground(color: UIColor) {
        contentView.backgroundColor = color
    }
    
}
