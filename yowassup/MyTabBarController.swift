//
//  TabBarController.swift
//  yowassup
//
//  Created by Matt Corrente on 1/31/18.
//  Copyright © 2018 Matt Corrente. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    var greetingModel = GreetingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingModel.loadGreetingFile()
    }
    
    func saveGreetingArray(updatedAr:[String]){
        greetingModel.saveGreetingFile(updatedAr: updatedAr)
    }
}
