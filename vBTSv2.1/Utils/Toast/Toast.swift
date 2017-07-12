//
//  Toast.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/1/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class Toast: NSObject {
    
    private let ORANGE_COLOR    = UIColor(red:0.98, green:0.55, blue:0.00, alpha:1.0)
    
    private let GREEN_COLOR     = UIColor(red:0.12, green:0.80, blue:0.00, alpha:1.0)
    
    private let RED_COLOR       = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
    
    private var superView       = UIView()
    
    private var subView         = UIView()
    
    private var timerToHiddenToast: NSTimer?
    
    private let iconToast       : UIImageView = {

        let iv = UIImageView()
        iv.image = UIImage(named: "ic_reload_25_white")
        iv.backgroundColor = UIColor.clearColor()
        iv.contentMode = .ScaleAspectFit
        return iv
    
    }()
    
    private let messageToast: UILabel = {

        let lb = UILabel()
        lb.text = "NO CONTENT"
        lb.textColor = UIColor.whiteColor()
        lb.textAlignment = .Left
        lb.font = UIFont(name: SaveText.FONT_OF_COMMON, size: 18.0)
        return lb
    
    }()
    
// ######################## GET/SET ################################
// #################################################################
    
    internal var setMessage: String {
        get {
            messageToast.text = ""
            return ""
        }
        set {
            messageToast.text = newValue
        }
    }
    
//    private var imgIconToast = UIImage(named:"ic_reload_25_white")
    internal var setImage: UIImage {
        get {
            iconToast.image = UIImage(named:"ic_reload_25_white")!
            return UIImage(named:"ic_reload_25_white")!
        }
        set {
            iconToast.image = newValue
        }
    }
    
    internal var setBackgroundColor: UIColor {
        get {
            self.subView.backgroundColor = UIColor.redColor()
            return UIColor.redColor()
        }
        set {
            self.subView.backgroundColor = newValue
        }
    }
    
// ######################## INIT ################################
// ##############################################################
    init(superView: UIView) {
        super.init()
        
        self.superView = superView
        
        self.setupSubview(subView)
        
        self.setupToast(subView)
        
    }
    
    internal func showToast() {
        
        self.superView.userInteractionEnabled = false
        
        timerToHiddenToast = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(hiddenToast), userInfo: nil, repeats: false)
        
        subView.frame = CGRectMake(0.0, 0.0, self.superView.frame.width, -subView.frame.height)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: {
            
            self.subView.frame = CGRectMake(0.0, 0.0, self.superView.frame.width, self.subView.frame.height)
            
            self.superView.addSubview(self.subView)
            
            }, completion: nil)
        
    }
    
    internal func hiddenToast() {
        
        self.superView.userInteractionEnabled = true
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: {
            
            let subviews = self.superView.subviews
            
            for subview in subviews {
                
                if (subview.tag == Tag.TAG_HIDDEN_TOAST) {
                    
                    subview.frame = CGRectMake(0.0, 0.0, self.superView.frame.width, -subview.frame.height)
                    self.superView.layoutIfNeeded()
                }
                
            }
            
            }, completion: nil) // ghi report ko Du :D
        
    }
    
    private func setupSubview(subview: UIView) {
        
        subview.frame = CGRect(x: 0.0, y: 0.0, width: self.superView.frame.size.width, height: 100)
        subview.backgroundColor = RED_COLOR
        subview.tag = Tag.TAG_HIDDEN_TOAST
        
    }
    
    private func setupToast(subview: UIView) {
        
        subview.addSubview(iconToast)
        subview.addSubview(messageToast)
        
        subView.addConstraintsViaFormat("H:|-10-[v0(25)]-10-[v1]-10-|", views: iconToast, messageToast)
        subview.addConstraintsViaFormat("V:[v0(25)]", views: iconToast)
        subview.addConstraintsViaFormat("V:[v0]", views: messageToast)
        
        subview.addConstraint(NSLayoutConstraint(item: iconToast, attribute: .CenterY, relatedBy: .Equal, toItem: subview, attribute: .CenterY, multiplier: 1, constant: 0))
        
        subview.addConstraint(NSLayoutConstraint(item: messageToast, attribute: .CenterY, relatedBy: .Equal, toItem: iconToast.self, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
    
}