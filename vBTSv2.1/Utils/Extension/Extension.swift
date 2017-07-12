//
//  Extension.swift
//  vBTSv2.1
//
//  Created by DatTran on 6/29/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func sha1() -> String! {
        
        let str         = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen      = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen   = Int(CC_SHA1_DIGEST_LENGTH)
        let result      = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        let hash        = NSMutableString()
        
        CC_SHA1(str!, strLen, result)
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(hash)
    }
}


extension UIView {
    
    func addConstraintsViaFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerate() {
            
            let key = "v\(index)"
            
            viewsDictionary[key] = view
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
}

extension UIViewController {
    
    func presentViewController(viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        presentViewController(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissViewController() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        dismissViewControllerAnimated(false, completion: nil)
    }
}