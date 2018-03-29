//
//  ViewController.swift
//  Calculator
//
//  Created by Nathan Burnett on 3/28/18.
//  Copyright © 2018 Nathan Burnett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CalculatorModel()
    let numCalculationLines = 7
    let indexOfFirstLine = 10
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchPreviousCalculation(_ sender: UIButton) {
        display.text! += sender.attributedTitle(for: .normal)!.string
    }

    private func updateCalculationsDisplay() {
        for i in indexOfFirstLine ..< indexOfFirstLine + numCalculationLines {
            let currentButton = self.view.viewWithTag(i) as? UIButton
            currentButton?.setAttributedTitle(model.getCalculation(i - indexOfFirstLine), for: .normal)
        }
    }
    
    @IBAction func touchEvaluate() {
        let textInDisplay = display.text!
        display.text = ""
        model.addCalculation(calculation: textInDisplay)
        updateCalculationsDisplay()
    }
    
    @IBAction func touchOperator(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if(operation == "(" || operation == ")"){
            display.text! += operation
        } else if(operation.count > 2){
            display.text! += operation + "("
        } else{
            display.text! += " " + operation + " "
        }
    }
    
    @IBAction func touchClear() {
        display.text = ""
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textInDisplay = display.text!
        display.text = textInDisplay + digit
    }
}

