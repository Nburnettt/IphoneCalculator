//
//  ViewController.swift
//  Calculator
//
//  Created by Nathan Burnett on 3/28/18.
//  Copyright © 2018 Nathan Burnett. All rights reserved.
//

import Expression
import UIKit

class ViewController: UIViewController {

    var lines: [NSMutableAttributedString] = [NSMutableAttributedString(), NSMutableAttributedString()]
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchPreviousCalculation(_ sender: UIButton) {
        
    }

    private func updateCalculationsDisplay() {
        let numCalculationLines = 7
        let indexOfFirstLine = 10
        let indexOfLastLine = indexOfFirstLine + numCalculationLines - 1
        
        let newCalculation = lines[1]
        let newResult = lines[0]
        
        var prev = NSAttributedString()
        
        for i in stride(from: indexOfLastLine, through: indexOfFirstLine, by: -1) {
            let currentButton = self.view.viewWithTag(i) as? UIButton
            if i - 2 >= indexOfFirstLine{
                let tmpButton = self.view.viewWithTag(i - 2) as! UIButton
                prev = tmpButton.attributedTitle(for: .normal)!
                currentButton?.setAttributedTitle(prev, for: .normal)
            }
        }
        let secondButton = self.view.viewWithTag(indexOfFirstLine + 1) as? UIButton
        secondButton?.setAttributedTitle(newCalculation, for: .normal)
        let firstButton = self.view.viewWithTag(indexOfFirstLine) as? UIButton
        firstButton?.setAttributedTitle(newResult, for: .normal)
    }
    
    private func createColoredString(_ myString: String, myColor: UIColor) -> NSMutableAttributedString {
        let myRange = NSMakeRange(0, myString.count)
        let attributedString = NSMutableAttributedString(string: myString)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: myColor, range: myRange)
        return attributedString
    }
    
    @IBAction func touchEvaluate() {
        let textInDisplay = display.text!
        var result = ""
        display.text = ""
        let expression = Expression(textInDisplay)
        do{
            result = String(try expression.evaluate())
        } catch {
            result = "Error"
        }
        lines[1] = createColoredString(textInDisplay, myColor: UIColor.lightGray)
        lines[0] = createColoredString(result, myColor: UIColor.green)
        updateCalculationsDisplay()
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        let operation = sender.currentTitle!
        display.text! += operation
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textInDisplay = display.text!
        display.text = textInDisplay + digit
    }
}

