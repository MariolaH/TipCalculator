//
//  ResultsViewController.swift
//  TipCalculator
//
//  Created by Mariola Hullings on 11/8/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    var totalPerPerson = "0.0"
    var splitBetween = 2
    var tip = 10.0
    var tipAsString = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = "$ \(totalPerPerson)"
        settingsLabel.text = "Split between \(splitBetween) people, with \(tipAsString)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
