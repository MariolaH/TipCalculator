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
    var tip: Double = 0.0
    var result = "0.0"
    var numberOfPeople = 2
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        percentNotSelected()
        sender.isSelected = true
        
        //displays tip option as a %
        let tipTitle = sender.currentTitle!
        //.dropLast removes the % and String is used to create a new string from the result of tip.dropLast()
        //This is necessary because the dropLast() method returns a substring
        let removePercent = String(tipTitle.dropLast())
        // Convert the removePercent string into a Double? and then forcefully unwraps it. tipInt is of type Double?
        let tipInt = Double(removePercent)!
        //Divide tipInt by 100 to get a decimal
        tip = tipInt / 100
        //        print(decimalTip)
        billTextField.endEditing(true)
    }
    
    func percentNotSelected() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
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
            self.percentNotSelected()
        })
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculate()
        self.performSegue(withIdentifier: "goToResults", sender: self)
        resetField()
    }
    
    func calculate() {
        if let billAmount = Double(billTextField.text ?? "0.0") {
            let tipAmount = billAmount * tip
            let checkTotal = tipAmount + (Double(billTextField.text!) ?? 0.0)
            let calculateSplit = checkTotal / Double(numberOfPeople)
            result = String(format: "%.2f", calculateSplit)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = result
            destinationVC.splitBetween = numberOfPeople
            destinationVC.tip = tip * 100
        }
    }
}

