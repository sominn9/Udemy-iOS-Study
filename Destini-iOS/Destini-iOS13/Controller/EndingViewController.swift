//
//  EndingViewController.swift
//  Destini-iOS13
//
//  Created by 신소민 on 2021/07/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable.text = storyBrain.getEndingTitle()
        subtitleLabel.text = storyBrain.getEndingSubtitle()
        contentLabel.text = storyBrain.getEndingContent()
        imageView.image = UIImage(named: storyBrain.getEndingImageName())
    }
    
    // MARK: - IBAction
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        storyBrain.storyNumber = 1
        storyBrain.storyHeight = 1
    }
}
