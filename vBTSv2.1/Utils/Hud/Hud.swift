//
//  Hud.swift
//  vBTSv2.1
//
//  Created by DatTran on 6/30/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

class Hud: NSObject {
    
    private var superView: UIView = UIView()
    
    private var subView: UIView = UIView()
    
    private let loading: UIActivityIndicatorView = {

        let ai = UIActivityIndicatorView()
        ai.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        ai.hidesWhenStopped = true
        ai.startAnimating()
        ai.color = UIColor.whiteColor()
        ai.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        return ai
        
    }()
    
    private let status: UILabel = {

        let lb = UILabel()
        lb.text = "Requesting..."
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_COMMON, size: 18.0)
        lb.textAlignment = .Center
        lb.sizeToFit()
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
// ######################## GET/SET ################################
// #################################################################
    
    private var txtStatus = ""
    
    internal var setMessage: String {
        
        get{
            
            status.text = ""
            
            return ""
            
        }
        set {
            
            status.text = newValue
            
        }
        
    }
    
// ######################## GET/SET ################################
// #################################################################
    
    init(superView: UIView) {
        super.init()
        
        self.superView = superView
        
        self.setupSubview(subView)
        
        self.setupHud(subView)
        
    }
    
    internal func startHud() {
        
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            
            self.superView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
            self.superView.addSubview(self.subView)
            self.superView.userInteractionEnabled = false
            
            }, completion: nil)
        
    }
    
    internal func stopHud() {
        
        
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            
            let subviews = self.superView.subviews
            
            for subview in subviews {
                
                if (subview.tag == Tag.TAG_HIDDEN_HUB) {
                    
                    
                    subview.removeFromSuperview()
                    
                }
                
            }
            
            self.superView.backgroundColor = SaveColor.BACKGROUND
            self.superView.userInteractionEnabled = true
            
        }, completion: nil)
        
    }
    
    private func setupSubview(subview: UIView) {
        
        subview.frame = CGRect(x: 0.0, y: 0.0, width: 120.0, height: 100.0)
        subview.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        subview.layer.cornerRadius = 10.0
        subview.layer.masksToBounds = true
        subview.center = (self.superView.center)
        subview.tag = Tag.TAG_HIDDEN_HUB
        
    }
    
    private func setupHud(subView: UIView) {
        
        subView.addSubview(loading)
        subView.addSubview(status)
        
        subView.addConstraintsViaFormat("H:|[v0]|", views: loading)
        subView.addConstraintsViaFormat("H:|-5-[v0]-5-|", views: status)
        subView.addConstraintsViaFormat("V:|-5-[v0(50)]-5-[v1(15)]", views: loading, status)
        
        
    }
    
}