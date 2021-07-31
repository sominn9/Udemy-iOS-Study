//
//  CalculatorBrain.swift
//  BMI-Calculator
//
//  Created by 신소민 on 2021/07/31.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)
    }
    
    func getBMIAdvice() -> String {
        return bmi?.advice ?? "No advice..."
    }
    
    func getBMIColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    mutating func calculateBMI(_ height: Float, _ weight: Float) {
        let bmiValue = weight / (height * height)
        
        if bmiValue > 24.9 {  // overweight
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        } else if bmiValue > 18.5 {  // normalweight
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else if bmiValue >= 0 {  // underweight
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else { // NaN (division by zero)
            bmi = BMI(value: 0.0, advice: "Please set the Height!", color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        }
     }
}
