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
            for num in contact.phoneNumbers {
                if num.label == CNLabelPhoneNumberMobile{
                    phoneNumbers.append((num.value).value(forKey: "digits") as! String)
                }
            }
        }
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        phoneNumbers.removeAll()
        
        // Populate recipient fields if at least one mobile # exists
        if phoneNumbers.count > 0 {
            let randomContactIndex = Int(arc4random_uniform(UInt32(phoneNumbers.count)))
            composeVC.recipients = [phoneNumbers[randomContactIndex]]
        }
        
        // Populate body field if at least one greeting exists
        if greetingAr.count > 0 {
            let randomMessageIndex = Int(arc4random_uniform(UInt32(greetingAr.count)))
            composeVC.body = greetingAr[randomMessageIndex];
        }
       
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        // Check the result or perform other tasks.
        
        // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)}
}
