//
//  LoginViewController.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    private
    var presenter: LoginPresenter?
    var hud: Hud?// = Hud(superView: self.view)
    
    override func viewDidLoad() {
        
        view.backgroundColor = SaveColor.BACKGROUND
        
        setupLoginView()
        setupHud()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        self.presenter?.showKeyboard()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.presenter?.hiddenKeyboard()
    }
    
    private func setupLoginView() {
        let loginView = LoginView.init(view: self.view)
        self.presenter = LoginPresenter.init(model: LoginModel(), view: loginView)
        loginView.delegate = self
        self.presenter?.delegate = self
    }
    
    private func setupHud() {
        hud = Hud(superView: self.view)
    }
    
}

extension LoginViewController: LoginButtonPressedDelegate {
    
    func login(username: String, password: String) {
        
        //### RULE TO CHECK VIA SORT #########################################################
        //### FIRST     : CHECK WHITESPACE OR LENGTH OF TEXT IN USERNAME AND PASSWORD TO SHOW ERROR
        //### SECOND    : CHECK REGEX AND LENGTH OF USERNAME TO SHOW ERROR
        //### THIRD     : CHECK LENGTH OF PASSWORD TO SHOW ERROR.
        
        let isUsernameHasAllWhitespace: Bool = (self.presenter?.isHasWhitespace(username))!
        
        let isPasswordHasAllWhitespace: Bool = (self.presenter?.isHasWhitespace(password))!
        
        let isValidUser: Bool = (self.presenter?.isValidUsername(username))!
        
        let isValidPass: Bool = (self.presenter?.isValidPassword(password))!
        
        if (!isUsernameHasAllWhitespace) {
            self.presenter!.view.showErrors(.UsernameEmpty)
            return
            
        } else if (!isPasswordHasAllWhitespace) {
            self.presenter!.view.showErrors(.PasswordEmpty)
            return
            
        } else if (!isValidUser) {
            self.presenter!.view.showErrors(.UsernameFailRegex)
            return
            
        } else if (!isValidPass) {
            self.presenter!.view.showErrors(.PasswordFailRegex)
            return
            
        } else {
            
            hud!.startHud()
            self.presenter?.getDataFromResponse(withUsername: username, withPassword: password)
            return
        }
    }
    
}


extension LoginViewController: LoginPresentDelegate {
    
    func autoLoadPage(typeAccount: StatusCode) {
        
        hud?.stopHud()
        
        if (typeAccount == .ADMIN) {
            
            let allStationViewController = WarningViewController(collectionViewLayout: UICollectionViewFlowLayout())
            let navAllStationViewController = UINavigationController(rootViewController: allStationViewController)
            self.presentViewController(navAllStationViewController)
            
        } else if (typeAccount == .OPERATOR) {
            
            let allStationViewController = WarningViewController(collectionViewLayout: UICollectionViewFlowLayout())
            let navAllStationViewController = UINavigationController(rootViewController: allStationViewController)
            self.presentViewController(navAllStationViewController)
            
        } else if (typeAccount == .USERSER_OR_PASSWORD_IS_INCORRECT) {
            
            self.presenter?.view.showErrors(.UserPassIncorrect)
            
        }
    
        
    }
    
}