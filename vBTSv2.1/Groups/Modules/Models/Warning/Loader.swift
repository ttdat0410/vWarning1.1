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
    
    static func executeWarningRequest(gatewaySerial: String, beginDateTime: String, endDateTime: String, success: LoaderSuccess, failure: LoaderFailure) {
        
        
        Alamofire.request(ServerManaer.Router.getWarning(gatewaySerial, beginDateTime, endDateTime)).responseJSON { response in
            
            print (response.result.value)
            
        }
        
    }
    
}
