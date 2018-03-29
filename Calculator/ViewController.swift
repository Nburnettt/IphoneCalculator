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

    var userIsTyping = false
    var linesOfCalculations: [String] = ["", "", "", "", "", "", "", "", "", ""]
    
    @IBOutlet weak var calculationsDisplay: UILabel!
    @IBOutlet weak var display: UILabel!
    
    private func updateCalculationsDisplay() {
        calculationsDisplay.text = ""
        while linesOfCalculations.count > 9 {
            linesOfCalculations.removeFirst()
        }
        for line in linesOfCalculations{
            if calculationsDisplay.text! != "" {
                calculationsDisplay.text! += "\n"
            }
            calculationsDisplay.text! += line
        }
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
        linesOfCalculations.append(textInDisplay)
        linesOfCalculations.append(result)
        updateCalculationsDisplay()
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        let operation = sender.currentTitle!
        display.text! += operation
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textInDisplay = display.text!
        if userIsTyping {
            display.text = textInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
}

