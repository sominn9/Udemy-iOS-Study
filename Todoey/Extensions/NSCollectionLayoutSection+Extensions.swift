//
//  NSCollectionLayoutSection+Extensions.swift
//  Todoey
//
//  Created by 신소민 on 2021/10/30.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

extension NSCollectionLayoutSection {
    
    static func responsiveGridSection(env: NSCollectionLayoutEnvironment, desiredWidth: CGFloat = 200) -> NSCollectionLayoutSection {
        let containerWidth = env.container.effectiveContentSize.width
        let itemCount: CGFloat = (containerWidth / desiredWidth).rounded()
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / itemCount),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1 / itemCount)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
}
