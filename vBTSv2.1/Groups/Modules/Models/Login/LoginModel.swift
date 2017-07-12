//
//  LoginModel.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit
import Alamofire

class LoginModel: NSObject {
    
    override init() {
        super.init()
    }
}

typealias Callback = ((complete: StatusCode) -> (Void))?

extension LoginModel: LoginModelDelegate {
    
    func exeLoginRequest(username: String, password: String, complete: LoginCallBack) {
        
        Alamofire.request(ServerManaer.Router.doLogin(username, password)).responseJSON { response in
            
            switch response.result {
                
            case .Success(let JSON):
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                
                let globalQueue = dispatch_get_global_queue(priority, 0)
                
                dispatch_async(globalQueue, {
                    
                    let status = ((JSON as! NSDictionary).valueForKey("status"))!
                    
                    let statusCode = (status.valueForKey("statusCode"))! as! Int
                    
                    if (statusCode == 1) {
                        
                        let data = ((JSON as! NSDictionary).valueForKey("data"))!
                        
                        let apiKey = (data.valueForKey("apiKey"))! as! String
                        
                        let userId = (data.valueForKey("userId"))! as! Int
                        
                        SharePreference.doSave("apiKey", value: apiKey)
                        SharePreference.doSave("userId", value: "\(userId)")
                        SharePreference.doSave("username", value: username)
                        SharePreference.doSave("password", value: password)
                        
                        Alamofire.request(ServerManaer.Router.getTypeAccount()).responseJSON(completionHandler: { (response) in
                            
                            switch response.result {
                                
                            case .Success(let JSON):
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                                    
                                    let dataOfTypeAccount = ((JSON as! NSDictionary).valueForKey("data"))!
                                    
                                    let roleId = (dataOfTypeAccount.valueForKey("roleId"))! as! Int
                                    
                                    if (roleId == 505) {
                                        complete?(complete: .ADMIN)
                                        
                                    } else if (roleId == 515) {
                                        complete?(complete: .OPERATOR)
                                        
                                    }
                                })
                                
                            case .Failure(let err):
                                print (err.localizedDescription)
                                complete?(complete: .FAILURE)
                            }
                        })
                        
                    } else if (statusCode == 9){
                        
                        complete?(complete: .USERSER_OR_PASSWORD_IS_INCORRECT)
                        
                    }
                })
                
            case .Failure(let err):
                print (err.localizedDescription)
                complete?(complete: .FAILURE)
                
            }
            
        }
    }
}
