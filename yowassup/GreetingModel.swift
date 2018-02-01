//
//  GreetingModel.swift
//  yowassup
//
//  Created by Matt Corrente on 1/31/18.
//  Copyright © 2018 Matt Corrente. All rights reserved.
//

import Foundation

//the purpose of this model is to allow an array of greetings to be shared with
//multiple view controllers
class GreetingModel: NSObject {
    var greetingsArray = [""]
    
    func saveGreetingFile(updatedAr:[String]) {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let writePath = documents.appendingPathComponent("greetingPList.plist")
        (updatedAr as NSArray).write(toFile: writePath, atomically: true)
        greetingsArray = updatedAr
    }//end saveGreetingFile
    
    func loadGreetingFile() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0)as! NSString
        let path = documentsDirectory.appendingPathComponent("greetingPList.plist")
        
        let fileManager = FileManager.default
        
        // Check if file exists
        if(!fileManager.fileExists(atPath: path))
        {
            // If it doesn't, copy it from the default file in the Resources folder
            do {
                let bundle = Bundle.main.path(forResource: "greetingPList", ofType: "plist")
                try fileManager.copyItem(atPath: bundle!, toPath: path)
                NSLog("copying resources folder")
            } catch {
                NSLog("error copying resources folder")
            }
        }
        else {
            NSLog("Success Loading File")
        }
        let data = NSArray(contentsOfFile: path) as? [String]
        greetingsArray = data!
    }//end loadGreetingFile
}
