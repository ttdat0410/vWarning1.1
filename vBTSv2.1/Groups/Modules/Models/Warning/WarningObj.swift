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
    var sensorTypeId    : Int = -1
    var warningValue1   : Int = -1
    var warningValue2   : Int = -1
    var warningComp     : Int = -1
    var originalValue   : Int = -1
    var value           : Int = -1
    
    override init () {
        super.init()
    }
    
    convenience init(time: String, createdTime: String, sensorName: String, sensorTypeId: Int, warningValue1: Int, warningValue2: Int, warningComp: Int, originalValue: Int, value: Int) {
        
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
