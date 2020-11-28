//
//  ViewController.swift
//  ListOfNames
//
//  Created by Łukasz Rajczewski on 28/11/2020.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    var names = [List]()
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNames()
    }
    
    func saveName() {
        do {
            try contex.save()
        } catch {
            print("Error saving name: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadNames() {
        
        let request: NSFetchRequest<List> = List.fetchRequest()
        
        do {
          names = try contex.fetch(request)
        } catch {
            print("Error loading names: \(error)")
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new name", message: "Type a name", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "name..."
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let text = textField.text {
                
                if text.count > 1 {
                    
                    let newName = List(context: self.contex)
                    newName.name = text
                    
                    self.names.append(newName)
                    self.saveName()
                }
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row].name
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

