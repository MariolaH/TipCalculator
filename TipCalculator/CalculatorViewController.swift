//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mariola Hullings on 11/8/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet var billTextField: UITextField!
    @IBOutlet weak var enterTipAmount: UITextField!
    @IBOutlet var splitNumberLabel: UILabel!
    @IBOutlet weak var stepperValue: UIStepper!
    var tip: Double = 0.0
    var result = "0"
    var numberOfPeople = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        style()
    }
    
    func style() {
        calculateButton.layer.cornerRadius = 25
    }
    
    @IBAction func tipChanged(_ sender: UITextField) {
        tipAmountEntered()
    }
    
    func tipAmountEntered() {
        if let tipText = enterTipAmount.text {
            let convertTip = Double(tipText) ?? 0.0
            tip = (convertTip == 0.0) ? 0.0 : convertTip / 100.00
        } else {
            tip = 0
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        enterTipAmount.endEditing(true)
        billTextField.endEditing(true)
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    func resetField() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("done")
            self.tip = 0.0
            self.result = "0.00"
            self.splitNumberLabel.text = "2"
            self.numberOfPeople = 2
            self.billTextField.text = ""
            self.enterTipAmount.text = ""
            self.stepperValue.value = 2
        })
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculate()
        tipAmountEntered()
        alertPopUp()
        resetField()
    }
    
    func alertPopUp() {
        if let totalAmount = Double(result), totalAmount > 0 {
            self.performSegue(withIdentifier: "goToResults", sender: self)
        } else {
            let alert = UIAlertController(title: "", message: "Enter Valid Bill Total", preferredStyle: .alert)
            let message = NSAttributedString(
                string: "Enter Valid Bill Total", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.00, green: 0.69, blue: 0.42, alpha: 1.00)])
            alert.setValue(message, forKey: "attributedMessage")
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.view.tintColor = UIColor(red: 0.00, green: 0.69, blue: 0.42, alpha: 1.00)
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0.84, green: 0.98, blue: 0.92, alpha: 1.00)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func calculate() {
        tipAmountEntered()
        if let billAmount = Double(billTextField.text ?? "0.00") {
            //            print(billAmount)
            let tipAmount = billAmount * tip
            //            print(tipAmount)
            let checkTotal = tipAmount + billAmount
            print(checkTotal)
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

extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

