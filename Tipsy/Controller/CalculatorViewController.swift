//
//  ViewController.swift
//  Tipsy
//
//  Created by Fernando González on 18/08/21.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tenPcButton: UIButton!
    @IBOutlet weak var fiveTeenPcButton: UIButton!
    @IBOutlet weak var twentyPcButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var uiStepper: UIStepper!
    
    var tipPercentage: Double?
    var total: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /* ten percentage button is selected */
        tenPcButton.isSelected = true
        
        /* Assigning the value to tip, because the 10% is selected */
        tipPercentage = 0.10
        
        /* getting the minimum value of the stepper and equalling to splitNumberLabel*/
        splitNumberLabel.text = String(Int(uiStepper.value))
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        /* End editing text field if is the case */
        billTextField.endEditing(true)
        
        /* changing all percentage buttons to unSelected */
        tenPcButton.isSelected = false
        fiveTeenPcButton.isSelected = false
        twentyPcButton.isSelected = false
        
        /* the button triggered changing to selected */
        sender.isSelected = true
        
        /* getting the title button triggered */
        let titleButton: String = sender.currentTitle!
        
        /* eliminating the last char % of the title and equalling to a Double percentage variable */
        let percentage: Double = Double(titleButton.dropLast())! / 100
        
        /* Assigning the percentage value to tip */
        tipPercentage = percentage
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        /* End editing text field if is the case */
        billTextField.endEditing(true)
        
        /* Assigning the value of the stepper */
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        /* getting the value of the Text Field (total amount)*/
        let billValue: Double = Double(billTextField.text!) ?? 0.0
        
        /* total = (total amount + tip) / split */
        total = (billValue + (billValue * tipPercentage!)) / Double(splitNumberLabel.text!)!
        
        print(total!)
        
        /* lets go to the Result view controller */
        self.performSegue(withIdentifier: "showResult", sender: self)
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            // getting the context of the Result view controller
            let dvController: ResultViewController = segue.destination as! ResultViewController
            
            dvController.percentage = tipPercentage
            dvController.total = total
            dvController.split = Double(splitNumberLabel.text!)!
            
        }
    }


}

