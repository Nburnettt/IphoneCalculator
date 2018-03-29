//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Nathan Burnett on 3/28/18.
//  Copyright © 2018 Nathan Burnett. All rights reserved.
//

import Foundation
import Expression

struct CalculatorModel {
    var calculationLines: [NSMutableAttributedString] = []
    
    func getCalculation(_ offset: Int = 0) -> NSMutableAttributedString{
        let calculationLinesSize = calculationLines.count
        if offset < calculationLinesSize{
            return calculationLines[calculationLinesSize - 1 - offset]
        }
        return NSMutableAttributedString()
    }
    
    func Calculate(calculation: String) -> String{
        let expression = Expression(calculation)
        do{
            return String(try expression.evaluate())
        } catch {
            return "Error"
        }
    }
    
    func createAttributeString(_ string: String, color: UIColor)-> NSMutableAttributedString {
        let entireStringRange = NSMakeRange(0, string.count)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: entireStringRange)
        attributedString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "Arial", size: 18.0)!, range: entireStringRange)
        return attributedString
    }
    
    mutating func addCalculation(calculation: String){
        let newCalculationLine = createAttributeString(calculation, color: UIColor.white)
        let newResult = Calculate(calculation: calculation)
        let newResultLine = createAttributeString(newResult, color: UIColor.green)
        
        calculationLines.append(newCalculationLine)
        calculationLines.append(newResultLine)
    }
    
}
