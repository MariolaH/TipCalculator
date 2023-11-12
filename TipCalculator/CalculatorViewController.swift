//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mariola Hullings on 11/8/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet weak var enterTipAmount: UITextField!
    @IBOutlet var splitNumberLabel: UILabel!
    var tip: Double = 0.0
    var result = "0.0"
    var numberOfPeople = 2
    
    @IBAction func tipChanged(_ sender: UITextField) {
        tipAmountEntered()
    }
    
    func tipAmountEntered() {
        if let tipText = enterTipAmount.text {
            print(tipText)
            var convertTip = Double(tipText) ?? 0.0
            tip = convertTip / 100.00
            print(tip)
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    func resetField() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("done")
            self.tip = 0.0
            self.result = "0.0"
            self.splitNumberLabel.text = "2"
            self.numberOfPeople = 2
            self.billTextField.text = ""
            self.enterTipAmount.text = ""
        })
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculate()
        tipAmountEntered()
        self.performSegue(withIdentifier: "goToResults", sender: self)
        resetField()
    }
    
    func calculate() {
        tipAmountEntered()
        if let billAmount = Double(billTextField.text ?? "0.0") {
//            print(billAmount)
            let tipAmount = billAmount * tip
//            print(tipAmount)
            let checkTotal = tipAmount + (Double(billTextField.text!) ?? 0.0)
//            print(checkTotal)
            let calculateSplit = checkTotal / Double(numberOfPeople)
//            print(calculateSplit)
            result = String(format: "%.2f", calculateSplit)
//            print(result)
//            print(enterTipAmount.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = result
            destinationVC.splitBetween = numberOfPeople
            destinationVC.tip = tip * 100
            destinationVC.tipAsString = enterTipAmount.text!
        }
    }
}

