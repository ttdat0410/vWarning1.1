//
//  LoginView.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit
import MaterialKit

protocol LoginButtonPressedDelegate {
    func login(username: String, password: String)
}

protocol LoginViewTapedDelegate {
    func dismissKeyboard()
}

class LoginView: NSObject {
    
    internal var delegate   : LoginButtonPressedDelegate?
    internal var loginCell  : LoginCell?
    internal var view       = UIView()
    internal var keyboard   : Keyboard?
    
    override init () {
        super.init()
    }
    
    convenience init (view: UIView) {
        
        self.init()
        self.view = view
        self.setupView()
        self.setupKeyboard()
        self.tapOnView()
        
    }
    
}

extension LoginView {
    
    func setupView() {
        
        self.loginCell = LoginCell.init(view: self.view)
        
        self.loginCell?.btnLogin.addTarget(self, action: #selector(LoginView.handleLogin), forControlEvents: .TouchUpInside)
        
    }
    
    func setupKeyboard() {
        
        self.keyboard = Keyboard(view: self.view, scrollView: (self.loginCell?.scrollView)!)
        
    }
    
    func tapOnView() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginView.handleTapOnView))
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
}

//############### HANDLE(s) #############################
//#######################################################

extension LoginView {
    
    func handleLogin(sender: MKButton) {
        
        self.keyboard?.dismissKeyboard()
        
        self.delegate?.login((self.loginCell?.tfUsername.text)! ?? "", password: (self.loginCell?.tfPassword.text)! ?? "")
    }
    
    func handleTapOnView(tapGesture: UITapGestureRecognizer) {
        
        self.keyboard?.dismissKeyboard()
        
    }
    
}


//############### IMPLEMENT PROTOCOL(s) ##################
//########################################################

extension LoginView: LoginViewDelegate {
    

    func showErrors(status: StatusLogin) {
                
        let toast = Toast(superView: self.view)
        
        switch status {
        case .UsernameEmpty:
            toast.setMessage = "ten dang nhap khong duoc de trong"
            toast.setImage = UIImage(named: SaveImage.IC_UESRNAME_50)!
            self.loginCell!.tfUsername.becomeFirstResponder()
            
        case .PasswordEmpty:
            toast.setMessage = "mat khau khong duoc de trong"
            toast.setImage = UIImage(named: SaveImage.IC_PASSWORD_50)!
            self.loginCell!.tfPassword.becomeFirstResponder()

        case .UsernameFailRegex:
            toast.setMessage = "ten dang nhap sai dinh dang"
            toast.setImage = UIImage(named: SaveImage.IC_UESRNAME_50)!
            self.loginCell!.tfUsername.becomeFirstResponder()
            
        case .PasswordFailRegex:
            toast.setMessage = "mat khau sai dinh dang"
            toast.setImage = UIImage(named: SaveImage.IC_PASSWORD_50)!
            self.loginCell!.tfPassword.becomeFirstResponder()
            
        case .UserPassIncorrect:
            toast.setMessage = "ten dang nhap, mat khau khong dung"
            toast.setImage = UIImage(named: SaveImage.IC_UESRNAME_50)!
            self.loginCell!.tfUsername.becomeFirstResponder()
            
        default:
            print("wtf?")
        }
        toast.showToast()
        
    }
    
    //------------------ KEYBOARD -------------------------
    //-----------------------------------------------------
    func showKeyboard() {
        
        print ("KEYBOARD SHOWED")
        self.keyboard?.registerKeyboard()
    }
    
    func hiddenKeyboard() {
        print ("KEYBOARD HIDDENED")
        self.keyboard?.unregisterKeyboard()
    }
    
}


