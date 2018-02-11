//
//  greetingListViewController.swift
//  yowassup
//
//  Created by Matt Corrente on 1/31/18.
//  Copyright © 2018 Matt Corrente. All rights reserved.
//

import UIKit

class GreetingViewListCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

class GreetingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addGreetingToList(_ sender: Any) {
        showInputDialog()
    }
    
    func showInputDialog() {
        
        let alertController = UIAlertController(title: "Add greeting?", message: "Enter the new greeting", preferredStyle: .alert)
        
        //if confirmed
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let newGreeting = alertController.textFields?[0].text
           
            self.greetingAr.append(newGreeting!)
            (self.tabBarController as? MyTabBarController)?.saveGreetingArray(updatedAr: self.greetingAr)
            self.tableView?.reloadData()
        }
        
        //if cancelled do nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //add the textfield
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Greeting"
        }
        
        //add the action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //display the dialog
        self.present(alertController, animated: true, completion: nil)
    }
    
    var greetingModel = GreetingModel()
    var greetingAr = [""]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //refresh the greeting array and reset the table
        //todo: refactor this into a funcion because the model/table only need to be refreshed
        //when user actually updates the table
        let tbvc = self.tabBarController as! MyTabBarController
        greetingModel = tbvc.greetingModel
        greetingAr = greetingModel.greetingsArray
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.greetingAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell:UITableViewCell = self.tableView!.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! GreetingViewListCell
        cell.label?.text = self.greetingAr[indexPath.row]
        
        //cell.textLabel?.text = self.greetingAr[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            NSLog("You selected cell #\(indexPath.row)!")
        }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.greetingAr.remove(at: indexPath.row)
            (self.tabBarController as? MyTabBarController)?.saveGreetingArray(updatedAr: self.greetingAr)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [delete]
    }
    
}
