//
//  WarningObj.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class WarningObj: NSObject {
    
    /*
     
     "time": "Jul 11, 2017 5:12:07 PM",
     "createdTime": "Jul 11, 2017 5:13:02 PM",
     "sensorName": "NA Motion",
     "sensorTypeId": 9,
     "warningValue1": 0,
     "warningValue2": 0,
     "warningComp": 1,
     "originalValue": 0,
     "value": 0
     
     */
    
    var time            : String = ""
    var createdTime     : String = ""
    var sensorName      : String = ""
    var sensorTypeId    : String = ""
    var warningValue1   : String = ""
    var warningValue2   : String = ""
    var warningComp     : String = ""
    var originalValue   : String = ""
    var value           : String = ""
    
    override init () {
        super.init()
    }
    
    convenience init(time: String, createdTime: String, sensorName: String, sensorTypeId: String, warningValue1: String, warningValue2: String, warningComp: String, originalValue: String, value: String) {
        
        self.init()
        
        self.time           = time
        self.createdTime    = createdTime
        self.sensorName     = sensorName
        self.sensorTypeId   = sensorTypeId
        self.warningValue1  = warningValue1
        self.warningValue2  = warningValue2
        self.warningComp    = warningComp
        self.originalValue  = originalValue
        self.value          = value
        
    }
    
}
