//
//  CalculateBrain.swift
//  04. BMI
//
//  Created by MacBook on 20.01.2025.
//

import UIKit

struct CalculateBrain {
    
    private var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)
        switch bmiValue {
        case 0...18.5 : bmi = BMI(value: bmiValue, advice: "ппц ты доходяга... ветром не уносит еще?", color: .systemBlue)
        case 18.5...24.9: bmi = BMI(value: bmiValue, advice: "нормальный!", color: .systemGreen)
        default: bmi = BMI(value: bmiValue, advice: "ну ты и толстяк...", color: .red)
        }
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value ?? 0.0)    //format: "%.1f" означает что после запятой будет один знак
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
}
