//
//  ViewController.swift
//  yowassup
//
//  Created by Matt Corrente on 1/27/18.
//  Copyright © 2018 Matt Corrente. All rights reserved.
//

import UIKit
import MessageUI
import Contacts

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var greetingModel = GreetingModel()
    var greetingAr = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //refresh the greeting array in case greetings were added/remove
        let tbvc = self.tabBarController as! MyTabBarController
        greetingModel = tbvc.greetingModel
        greetingAr = greetingModel.greetingsArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toRandomContactPressed(_ sender: UIButton){
        
        var phoneNumbers = [String]()
        
        let contactStore = CNContactStore()
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey as CNKeyDescriptor])
        try! contactStore.enumerateContacts(with: fetchRequest) { contact, stop in
            if contact.phoneNumbers.count > 0 {
                phoneNumbers.append((contact.phoneNumbers[0].value ).value(forKey: "digits") as! String)
            }
        }
        
//todo check that multiple numbers actually exist!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//todo should probably confirm that numbers are all from mobile category
        
        let randomContactIndex = Int(arc4random_uniform(UInt32(phoneNumbers.count)))
        let randomMessageIndex = Int(arc4random_uniform(UInt32(greetingAr.count)))
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Populate recipient and body fields
        composeVC.recipients = [phoneNumbers[randomContactIndex]]
        composeVC.body = greetingAr[randomMessageIndex];
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        // Check the result or perform other tasks.
        
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)}

}

