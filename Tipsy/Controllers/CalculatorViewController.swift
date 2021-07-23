//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Double = 0.1
    var numberOfPeople: Int = 2
    var billPerson: Double = 0.0

    // MARK: - IBActions
    @IBAction func tipChanged(_ sender: UIButton) {
        // Deselect all tip buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Select the pressed button
        sender.isSelected = true
        
        // Get the tip percent (20 -> 0.2)
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsNumber / 100
        
        // Dismiss the keyboard on the textfield
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let billTotal = Double(billTextField.text!) {
            billPerson = billTotal * (1 + tip) / Double(numberOfPeople)
            billPerson = round(billPerson * 100) / 100  // two decimal place
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.tip = tip
            resultVC.numberOfPeople = numberOfPeople
            resultVC.billPerson = billPerson
        }
    }
}

