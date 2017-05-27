//
//  ViewController.swift
//  I Owe Money
//
//  Created by Kevin on 2017-05-21.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "I Owe Money To..."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch {
            print("Could not fetch data")
        }
    }
    
    func remove(index: Int) {
        let person = people[index]
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(person)
        people.remove(at: index)
        
        do {
            try managedContext.save()
        } catch {
            print("Unable to remove person")
        }
    }
    
    func save(name: String, amount: Double, due: Date) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        
        let person = Person(entity: entity, insertInto: managedContext)
        
        person.name = name
        person.amount = amount
        person.due = due as NSDate
        
        do {
            try managedContext.save()
            people.append(person)
            people.sort(by: { ($0.due! as Date) < ($1.due! as Date) })
            self.tableView.reloadData()
        } catch {
            print("Failure to save data")
        }
    }
    
    @IBAction func cancelToViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveDebtDetail(segue: UIStoryboardSegue) {
        if let debtDetailsViewController = segue.source as? DebtDetailsViewController {
            self.save(name: debtDetailsViewController.debtee!, amount: debtDetailsViewController.debtAmount!,
                      due: debtDetailsViewController.due!)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let deletionAlert = UIAlertController(title: "Warning",
                                              message: "Are you sure?",
                                              preferredStyle: .alert)
        
        deletionAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            if (editingStyle == UITableViewCellEditingStyle.delete) {
                self.remove(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                tableView.reloadData()
            }

        }))
        
        deletionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.tableView.isEditing = false
        }))
        
        present(deletionAlert, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AppViewCell
        
        let person = people[indexPath.row]
        
        let name = person.name
        let amount = person.amount
        let due = person.due

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dueString = dateFormatter.string(from: due! as Date)

        cell.dueDateLabel.text = dueString
        cell.nameLabel.text = name
        cell.amountLabel.text = "$" + String(format: "%.2f", amount)
        return cell
    }
}

extension UIAlertController {
    func hasName(_ name: String) -> Bool {
        return name.characters.count > 0
    }
    
    func isValidAmount(_ amount: String) -> Bool {
        if Double(amount) != nil {
            return amount.characters.count > 0
        }
        return false
    }
    
    func textDidChangeAlert() {
        if let name = textFields?[0].text,
            let amount = textFields?[1].text,
            let action = actions.last {
            action.isEnabled = hasName(name) && isValidAmount(amount)
        }
    }
}
