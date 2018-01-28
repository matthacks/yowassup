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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(phoneNumbers.count)))
        print(phoneNumbers[randomIndex])
        
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        
        // Configure the fields of the interface.
        composeVC.recipients = [phoneNumbers[randomIndex]]
        composeVC.body = "YO WASSUP!"
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        // Check the result or perform other tasks.
        
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)}

}

