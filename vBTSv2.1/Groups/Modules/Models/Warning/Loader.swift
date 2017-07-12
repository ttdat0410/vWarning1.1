//
//  oader.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit
import Alamofire

typealias LoaderSuccess = ((warnings: Array<WarningObj>) -> (Void))?
typealias LoaderFailure = ((error: NSError) -> (Void))?

class Loader {
    
    static func executeWarningRequest(gatewaySerial: String, count: String, success: LoaderSuccess, failure: LoaderFailure) {
        
        Alamofire.request(ServerManaer.Router.getWarning(gatewaySerial, count)).responseJSON { (response) in
            
            switch response.result {
                
            case .Success(let JSON):
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                let global = dispatch_get_global_queue(priority, 0)
                
                dispatch_async(global, {
                    
                    let status = ((JSON as! NSDictionary).valueForKey("status"))!
                    
                    let statusCode = (status.valueForKey("statusCode"))! as! Int
                    
                    if (statusCode == 1) {
                        
                        let data = ((JSON as! NSDictionary).valueForKey("data"))!
                        
                        let sensorWarningList = data.valueForKey("sensorWarningList")
                        
                        let contentSensorWarningsList = ((sensorWarningList as! NSDictionary).valueForKey("sensorWarningList"))! as! NSArray
                        
                        var warnings = [WarningObj]()
                        
                        for contentSensorWarningList in contentSensorWarningsList {
                        
                        let time            = contentSensorWarningList.valueForKey("time") as! String
                        let createdTime     = contentSensorWarningList.valueForKey("createdTime") as! String
                        let sensorName      = contentSensorWarningList.valueForKey("sensorName") as! String
                        let sensorTypeId    = contentSensorWarningList.valueForKey("sensorTypeId") as! Int
                        let warningValue1   = contentSensorWarningList.valueForKey("warningValue1") as! Int
                        let warningValue2   = contentSensorWarningList.valueForKey("warningValue2") as! Int
                        let warningComp     = contentSensorWarningList.valueForKey("warningComp") as! Int
                        let originalValue   = contentSensorWarningList.valueForKey("originalValue") as! Int
                        let value           = contentSensorWarningList.valueForKey("value") as! Int
                        
                        warnings.append(WarningObj.init(time: time, createdTime: createdTime, sensorName: sensorName, sensorTypeId: sensorTypeId, warningValue1: warningValue1, warningValue2: warningValue2, warningComp: warningComp, originalValue: originalValue, value: value))
                        
                        }
                        
                        success?(warnings: warnings)
                        
                    } else {
                        return
                    }
                    
                    
                })
            case .Failure(let error):
                failure?(error: error)
            }
            
        }
    }
    
}
