//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton! // Has Identifier = choice1
    @IBOutlet weak var choice2Button: UIButton! // Has Identifier = choice2
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateStoryUI()
    }

    // MARK: - Methods
    @IBAction func choiceMade(_ sender: UIButton) {
        
        let buttonIndentifier: String = sender.accessibilityIdentifier!
        let isStoryExists: Bool = storyBrain.nextStory(userChoice: buttonIndentifier)
        
        if isStoryExists {
            // 다음에 보여줄 스토리가 있으면, 버튼을 누르고 0.3초 후에 다음 스토리를 보여준다
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {
                _ in
                self.updateStoryUI()
            })
        } else {
            // 다음에 보여줄 스토리가 없으면, 버튼을 누르고 0.3초 후에 엔딩을 보여준다
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {
                _ in
                self.showEnding()
            })
        }
    }
    
    func updateStoryUI() {
        storyLabel.text = storyBrain.getTitle()
        
        let choices = storyBrain.getChoices()
        choice1Button.setTitle(choices[0], for: .normal)
        choice2Button.setTitle(choices[1], for: .normal)
    }
    
    func showEnding() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let endingViewController = storyBoard.instantiateViewController(withIdentifier: "endingView") as! EndingViewController
        endingViewController.modalPresentationStyle = .fullScreen
        self.present(endingViewController, animated:true, completion:nil)
    }
}

