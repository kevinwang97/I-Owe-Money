//
//  DebtDetailsViewController.swift
//  I Owe Money
//
//  Created by Kevin on 2017-05-23.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class DebtDetailsViewController: UITableViewController {

    @IBOutlet weak var done: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var hasDueDate: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var debtAmount: Double?
    var debtee: String?
    var due: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func dueSliderValChanged(_ sender: UISwitch) {
        UIView.transition(with: self.datePicker, duration: 0.5, options: .transitionFlipFromTop, animations: { _ in self.datePicker.isHidden = !self.datePicker.isHidden}, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveDebtDetail" {
            debtAmount = Double((amountTextField?.text)!)
            debtee = nameTextField?.text
            if hasDueDate.isOn {
                due = datePicker.date
            }
        }
    }
    
    func textDidChange() {
        func hasName(_ name: String) -> Bool {
            return name.characters.count > 0
        }
        
        func isValidAmount(_ amount: String) -> Bool {
            if Double(amount) != nil {
                return amount.characters.count > 0
            }
            return false
        }
        
        if let name = nameTextField?.text!,
            let amount = amountTextField?.text! {
            if (hasName(name) && isValidAmount(amount)) {
                self.done.isEnabled = true
            } else {
                self.done.isEnabled = false
            }
        }
    }

    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        textDidChange()
    }

    @IBAction func amountTextFieldChanged(_ sender: UITextField) {
        textDidChange()
    }

}
