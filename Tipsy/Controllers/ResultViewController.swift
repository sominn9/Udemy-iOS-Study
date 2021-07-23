//
//  ResultViewController.swift
//  Tipsy
//
//  Created by 신소민 on 2021/07/23.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    // MARK: Properties
    var tip: Double?  // e.g. 0.2
    var numberOfPeople: Int?
    var billPerson: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = String(billPerson!)
        settingsLabel.text = "Split between \(numberOfPeople!) people, with \(Int(tip! * 100))% tip."
    }
    
    // MARK: - IBAction
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
