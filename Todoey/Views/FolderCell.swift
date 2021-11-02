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
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var selectLabel: UILabel = {
        let selectLabel = UILabel()
        
        // Set the label detail
        selectLabel.layer.cornerRadius = 15
        selectLabel.layer.masksToBounds = true
        selectLabel.layer.borderWidth = 1
        selectLabel.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        selectLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        selectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the checkmark image at label and Hide it
        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backgroundImageView.image = UIImage(systemName: "checkmark.circle.fill")
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.tintColor = UIColor.white.withAlphaComponent(0.7)
        selectLabel.insertSubview(backgroundImageView, at: 0)
        selectLabel.subviews[0].isHidden = true
        
        return selectLabel
    }()
    
    var isEditing: Bool = false {
        didSet {
            selectLabel.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectLabel.layer.borderWidth = 0
                selectLabel.backgroundColor = .clear
                selectLabel.subviews[0].isHidden = false
            } else {
                selectLabel.layer.borderWidth = 1
                selectLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                selectLabel.subviews[0].isHidden = true
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            contentView.alpha = isHighlighted ? 0.7 : 1.0
        }
    }
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Label settings
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15)
        ])
        
        // Select Label settings
        contentView.addSubview(selectLabel)
        NSLayoutConstraint.activate([
            selectLabel.widthAnchor.constraint(equalToConstant: 30),
            selectLabel.heightAnchor.constraint(equalToConstant: 30),
            selectLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            selectLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        // Background settings
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureLabel(text: String) {
        label.text = text
    }
    
}
