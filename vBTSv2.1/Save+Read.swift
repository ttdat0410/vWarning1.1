//
//  Save+Read.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/10/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit


class SharePreference {
    
    class var shareInstance: SharePreference {
        
        struct Singleton {
            
            static let instance = SharePreference()
            
        }
        return Singleton.instance
        
    }
    
    static func doSave (key: String, value: String) {
        
        let preferences     = NSUserDefaults.standardUserDefaults()
        
        let key             = key
        
        let content_key     = value
        
        preferences.setObject(content_key, forKey: key)
        
        let didSave = preferences.synchronize()
        
        if !didSave {
            debugPrint("Couldn't save!")
        }
        
    }
    
    static func doRead (withKey: String) -> String {
        
        var output          : String = ""
        
        let preferences     = NSUserDefaults.standardUserDefaults()
        
        let getKey          = "\(withKey)"
        
        if preferences.objectForKey(getKey) == nil {
            debugPrint("Don't exits key")
            
        } else {
            
            output = preferences.objectForKey(getKey) as! String
            
        }
        
        return output
        
    }
    
}
