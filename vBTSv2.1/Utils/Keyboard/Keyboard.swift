//
//  Keyboard.swift
//  vBTSv2.1
//
//  Created by DatTran on 6/30/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class Keyboard: NSObject {
    
    private var scrollView: UIScrollView?
    
    private var view: UIView?
    
    init(view: UIView, scrollView: UIScrollView) {
        
        self.scrollView = scrollView
        self.view = view
        
    }
    
    internal func registerKeyboard() {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHidden), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    internal func unregisterKeyboard() {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    private var username: UITextField?
    private var password: UITextField?
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let scrollView = scrollView else {
            return
        }
        
        guard let view = view else {
            return
        }
        
//        scrollView.scrollEnabled = true
        
        let info = notification.userInfo
        
        let keyboardSize = (info![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        let contentInset: UIEdgeInsets = UIEdgeInsetsMake(-keyboardSize.height/2, 0.0, 0.0, 0.0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        var aRect = view.frame
        
        aRect.size.height -= keyboardSize.height
        
        if let activeUser = username, let activePass = password {
            
            if (aRect.contains(activeUser.frame.origin)) {
                scrollView.scrollRectToVisible(activeUser.frame, animated: true)
            }
            
            if (aRect.contains(activePass.frame.origin)) {
                scrollView.scrollRectToVisible(activePass.frame, animated: true)
            }
            
        }
        
        
    }
    
    @objc private func keyboardWillHidden(notification: NSNotification) {
        
        guard let scrollView = scrollView else {
            return
        }
        
        guard let view = view else {
            return
        }
        
        let info = notification.userInfo
        
        let keyboardSize = (info![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        let contentInset: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize.height, 0.0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        
        view.endEditing(false)
//        scrollView.scrollEnabled = false
        
    }
    
    internal func dismissKeyboard() {
        
        guard let view = view else {
            return
        }
        
        view.endEditing(true)
        
    }
    
}