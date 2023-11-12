//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mariola Hullings on 11/8/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    var tipAmount: Double = 0.0
    var printTwoDecimalPoints = "0.0"
    var numberOfPeople = "2"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        //displays tip option as a %
        let tip = sender.currentTitle!
        //.dropLast removes the % and String is used to create a new string from the result of tip.dropLast()
        //This is necessary because the dropLast() method returns a substring
        let removePercent = String(tip.dropLast())
        // Convert the removePercent string into a Double? and then forcefully unwraps it. tipInt is of type Double?
        let tipInt = Double(removePercent)!
        //Divide tipInt by 100 to get a decimal
        let decimalTip = tipInt / 100
        //        print(decimalTip)
        tipAmount = decimalTip
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let split = String(format: "%.0f", sender.value)
        splitNumberLabel.text = split.description
        numberOfPeople = split
        
        //        print(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
   calculate()
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    func calculate() {
        let howManyWaysToSplit = splitNumberLabel.text!
        let tippedAmount = (Double(billTextField.text!) ?? 0.0) * tipAmount
        let check = tippedAmount + (Double(billTextField.text!) ?? 0.0)
        let calculateSplit = check / Double(howManyWaysToSplit)!
        printTwoDecimalPoints = String(format: "%.2f", calculateSplit)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = printTwoDecimalPoints
            destinationVC.splitBetween = numberOfPeople
            destinationVC.tip = tipAmount * 100
        }
    }
}

