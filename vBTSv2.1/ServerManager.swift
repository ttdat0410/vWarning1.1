//
//  ServerManager.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/10/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//


import Foundation
import Alamofire


public protocol ResponseCollectionSerializable {
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
    
}

extension Alamofire.Request {
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            
            guard error == nil else {
                
                return .Failure(error!)
            }
            
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
                
            case .Success(let value):
                
                if let response = response {
                    
                    return .Success(T.collection(response: response, representation: value))
                    
                } else {
                    
                    let failureReason = "FAIL"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                    
                }
                
                
            case .Failure(let error):
                return .Failure(error)
            }
            
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
        
    }
}

public protocol ResponseObjectSerialzable {
    
    init?(response: NSHTTPURLResponse, representation: AnyObject)
    
}

extension Alamofire.Request {
    
    public func responseObject<T: ResponseObjectSerialzable> (completionHandler: Response<T, NSError> -> Void) -> Self {
        
        let responseSerializer = ResponseSerializer<T, NSError> {
            request, response, data, error in
            
            
            guard error == nil else {
                return .Failure(error!)
                
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
                
            case .Success(let value):
                
                if let response = response, JSON = T(response: response, representation: value) {
                    return .Success(JSON)
                } else {
                    let failureReason = "FAIL"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
                
            case .Failure(let error):
                return .Failure(error)
                
            }
            
            
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
        
    }
    
}

