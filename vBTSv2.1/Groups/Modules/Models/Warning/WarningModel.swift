//
//  WarningModel.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

enum UpdateStatus {
    
    case Idle
    case Loading
    
}

typealias LoadWarningSuccess = (() -> (Void))?
typealias LoadWarningFailure = ((error: NSError) -> (Void))?

class WarningModel: NSObject {
    
    private(set)
    var warnings = [WarningObj]()
    var updateStatus = UpdateStatus.Idle as UpdateStatus
    var loader: Loader?
    
    override init () {
        super.init()
    }
    
    func loadWarning(gatewaySerial: String, count: String, success: LoadWarningSuccess, failure: LoadWarningFailure) {
        
        if(updateStatus == .Idle) {
            updateStatus = .Loading
        }
        
        Loader.executeWarningRequest(gatewaySerial, count: count, success: { (warnings) -> (Void) in
            
            self.warnings = warnings
            self.updateStatus = .Idle
            success?()
            
            }) { (error) -> (Void) in
                
                self.updateStatus = .Idle
                failure?(error: error)
                
        }
        
    }
    
}

extension WarningModel: WarningModelDelegate {
    
    func getWarning() -> NSArray {
        
        if (self.warnings.count > 0) {
            
            return self.warnings
        }
        let semaphone = dispatch_semaphore_create(0) as dispatch_semaphore_t
        
        self.loadWarning("GW170614", count: "10", success: { () -> (Void) in
            
            dispatch_semaphore_signal(semaphone)
            
            }) { (error) -> (Void) in
                
                dispatch_semaphore_signal(semaphone)
                
        }
        
        dispatch_semaphore_wait(semaphone, DISPATCH_TIME_FOREVER)
        return self.warnings
    }
    
}
