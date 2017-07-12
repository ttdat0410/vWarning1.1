//
//  ServerManagerRequestRouter.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/10/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import Alamofire

struct ServerManaer {
    
    enum Router: URLRequestConvertible {
                
        static var baseURL: String {
            return "http://113.161.61.89:8081/BTSRestWebService"
        }
        static var apiKey: String {
            return SharePreference.doRead("apiKey") ?? ""
        }
        static var userId: String {
            return SharePreference.doRead("userId") ?? ""
        }
        
        case getTypeAccount()
        case doLogin(String, String)                    // username + password
        case getWarning(String, String)                 // gatewaySerial + count
        
        
// ######### METHOD
        var method: Alamofire.Method {
            
            switch self {
            case .getTypeAccount:
                return .GET
                
            case .doLogin:
                return .GET
                
            case .getWarning:
                return .GET
            
            }
            
        }
        
// ######### PATH
        var path: String {
            
            switch self {
            case .getTypeAccount:
                return "/account/getMyAccountInfo/\(SharePreference.doRead("userId"))"
                
            case .doLogin:
                return "/apikey/login"
                
            case .getWarning(let gatewaySerial, _ ):
                return "report/warning/getLast/\(Router.userId)/\(gatewaySerial)"
                
            }
        }
        
// ######### PARAMETER
        var parammeters: [String: AnyObject] {
            
            switch self {
            case .doLogin(let username, let password):
                let params = ["username": username, "password": password.sha1()]
                return params
                
            case .getTypeAccount:
                return [:]
                
            case .getWarning( _ , let count):
                let params = ["count": count]
                return params
            
            }
            
        }
        
        // ###
        var URLRequest: NSMutableURLRequest {
            
            let result: (path: String, parameters: [String: AnyObject]) = {
                return (path, parammeters)
            }()
            
            let URL = NSURL(string: Router.baseURL)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
            mutableURLRequest.setValue(Router.apiKey, forHTTPHeaderField: "API_KEY")
            mutableURLRequest.HTTPMethod = method.rawValue
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: result.parameters).0
            
        }
        
    }
    
}