//
//  LoginPresenter.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

protocol LoginPresentDelegate {
    func autoLoadPage(typeAccount: StatusCode)
}

class LoginPresenter: NSObject {
    
    
    internal var model: LoginModelDelegate = LoginModel()
    internal var view: LoginViewDelegate =  LoginView()
    
    var delegate: LoginPresentDelegate?
    
    override init() {
        super.init()
    }
    
    convenience init(model: LoginModelDelegate, view: LoginViewDelegate) {
        self.init()
        self.model = model
        self.view = view
    }
    
    func getDataFromResponse(withUsername username: String, withPassword password: String) {
        
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(globalQueue) {
            
            self.model.exeLoginRequest(username ?? "", password: password ?? "", complete: { (complete) -> (Void) in
                dispatch_async(dispatch_get_main_queue(), {
//                    self.view.updateView(complete)
                    self.delegate?.autoLoadPage(complete)
                })
            })
        }
        
    }
    
}


//########### VALIDATOR ###################
//########################################
extension LoginPresenter {
    
    func isValidUsername (username: String) -> Bool {
        
        let regex: String = "[0-9A-Za-z]{3,10}"
        
        let validator = NSPredicate(format: "SELF MATCHES %@", regex)
        
        let valid = validator.evaluateWithObject(username)
        
        return valid
        
    }
    
    func isValidPassword (password: String) -> Bool {
        
        return (password.isEmpty || password.characters.count < 5) ? false : true
        
    }
    
    func isHasWhitespace(input: String) -> Bool {
        
        let whiteSpace: NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        
        let output = input.stringByTrimmingCharactersInSet(whiteSpace)
        
        return (output.characters.count < 1) ? false : true
        
    }
    
}

//########### KEYBOARD ###################
//########################################
extension LoginPresenter {
    
    func showKeyboard() {
        self.view.showKeyboard()
    }
    
    func hiddenKeyboard() {
        self.view.hiddenKeyboard()
    }
    
}
