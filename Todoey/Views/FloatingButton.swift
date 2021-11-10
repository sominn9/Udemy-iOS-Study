//
//  FloatingButton.swift
//  Todoey
//
//  Created by 신소민 on 2021/11/10.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = .black
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false

        self.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        
        let plusImage = UIImage.init(systemName: "plus")?
            .applyingSymbolConfiguration(.init(weight: .bold))?
            .applyingSymbolConfiguration(.init(scale: .large))
        self.setImage(plusImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFloatingImage(systemName: String, for state: UIControl.State) {
        if let image = UIImage.init(systemName: systemName) {
            image.applyingSymbolConfiguration(.init(weight: .bold))?
                 .applyingSymbolConfiguration(.init(scale: .large))
            self.setImage(image, for: state)
        }
    }
    
}
