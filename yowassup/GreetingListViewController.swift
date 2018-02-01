//
//  greetingListViewController.swift
//  yowassup
//
//  Created by Matt Corrente on 1/31/18.
//  Copyright © 2018 Matt Corrente. All rights reserved.
//

import UIKit

class GreetingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
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
        
        let cell:UITableViewCell = self.tableView!.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        cell.textLabel?.text = self.greetingAr[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            NSLog("You selected cell #\(indexPath.row)!")
        }
    
}
