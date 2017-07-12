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
        case doLogin(String, String)
        case getAllStation()
        case getOneStation()
        case getChart()
        case getWarning(String, String, String)
        
        
// ######### METHOD
        var method: Alamofire.Method {
            
            switch self {
            case .getTypeAccount:
                return .GET
                
            case .doLogin:
                return .GET
                
            case .getWarning:
                return .GET
            
            default:
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
                
            case .getWarning(let gatewaySerial, _,_):
                return "/report/warning/\(Router.userId)/\(gatewaySerial)"
                
            default:
                return ""
            }
            
        }
        
// ######### PARAMETER
        var parammeters: [String: AnyObject] {
            
            switch self {
            case .doLogin(let username, let password):
                let params = ["username": username, "password": password.sha1()]
                return params
                
            case .getWarning( _ , let beginDateTime, let endDateTime):
                let params = ["beginDateTime": beginDateTime, "endDateTime": endDateTime]
                return params
                
            case .getAllStation:
                return [:]
                
            default:
                return [:]
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
            print (mutableURLRequest)
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: result.parameters).0
            
        }
        
    }
    
}