//
//  LoginCell.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/8/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit
import MaterialKit

class LoginCell: UIView {
    
    private let imgUsername: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: SaveImage.IC_UESRNAME_50)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        iv.contentMode = .ScaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    private let imgPassword: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: SaveImage.IC_PASSWORD_50)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        iv.contentMode = .ScaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    private let lbUsername: UILabel = {
        
        let lb = UILabel()
        lb.text = SaveText.EMAIL
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 15.0)
        lb.textAlignment = .Left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
        
    }()
    
    private let lbPassword: UILabel = {
        
        let lb = UILabel()
        lb.text = SaveText.PASSWORD
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 15.0)
        lb.textAlignment = .Left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
        
    }()
    
    internal let tfUsername: MKTextField = {
        
        let tf = MKTextField()
        
        tf.text = SharePreference.doRead("username") ?? ""
        tf.floatingPlaceholderEnabled = false
        tf.attributedPlaceholder = NSAttributedString.init(string: SaveText.ENTER_EMAIL, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5)])
        tf.textColor = UIColor.whiteColor()
        tf.font = UIFont(name: SaveText.FONT_OF_COMMON, size: 18.0)
        tf.backgroundColor = UIColor.clearColor()
        tf.layer.borderColor = UIColor.clearColor().CGColor
        tf.layer.cornerRadius = 3.5
        tf.layer.masksToBounds = true
        tf.tintColor = UIColor.whiteColor()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = Tag.TAG_TF_USERNAME
        
        return tf
        
    }()
    
    internal let tfPassword: MKTextField = {
        
        let tf = MKTextField()
        
        tf.text = SharePreference.doRead("password") ?? ""
        tf.floatingPlaceholderEnabled = false
        tf.attributedPlaceholder = NSAttributedString.init(string: SaveText.ENTER_PASSWORD, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5)])
        tf.textColor = UIColor.whiteColor()
        tf.font = UIFont(name: SaveText.FONT_OF_COMMON, size: 18.0)
        tf.backgroundColor = UIColor.clearColor()
        tf.layer.borderColor = UIColor.clearColor().CGColor
        tf.layer.cornerRadius = 3.5
        tf.layer.masksToBounds = true
        tf.tintColor = UIColor.whiteColor()
        tf.secureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tag = Tag.TAG_TF_PASSWORD
        
        return tf
        
    }()
    
    private let horUsername: UIView = {
        
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    private let horPassword: UIView = {
        
        let v = UIView()
        v.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    internal let btnLogin: MKButton = {
        
        let btn = MKButton()
        btn.maskEnabled = true
        btn.enabled = true
        btn.setTitle(SaveText.SIGNIN, forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 18.0)
        btn.backgroundColor = UIColor.clearColor()
        btn.layer.cornerRadius = 22.0
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.whiteColor().CGColor
        btn.layer.borderWidth = 1.5
        
        return btn
        
    }()
    
    private let lbBts: UILabel = {
        
        let lb = UILabel()
        lb.text = SaveText.BTS
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 110.0)
        lb.textAlignment = .Center
        
        return lb
        
    }()
    
    private let lbAnsv: UILabel = {
        
        let lb = UILabel()
        lb.text = SaveText.VERSION
        lb.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        lb.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 15.0)
        lb.textAlignment = .Center
        return lb
        
    }()
    private let lbTime: UILabel = {
        
        let lb = UILabel()
        lb.text = SaveText.ADDRESS
        lb.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        lb.font = UIFont(name: SaveText.FONT_OF_FIELD, size: 15.0)
        lb.textAlignment = .Center
        return lb
        
    }()
    
    internal let scrollView: UIScrollView = {
        
        let sv = UIScrollView()
        sv.frame = UIScreen.mainScreen().bounds
        sv.backgroundColor = UIColor.clearColor()
        sv.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-64)
        sv.scrollEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        return sv
        
    }()
    
// #### SINGLATON
    typealias ViewConfig = UIView
    
    class SharedInstance  {
        
        enum E : ErrorType {
            case config(message: String)
        }
        
        private static var instance: SharedInstance!
        
        private(set) var config: ViewConfig?
        
        private init(config: ViewConfig?) {
            
            self.config = config
            SharedInstance.instance = self
            
        }
        
        static func shared(config: ViewConfig? = nil) throws -> SharedInstance {
            
            switch (instance, config) {
                
            case let (i?, nil):
                return i
                
            case _ where instance != nil && config != nil:
                throw E.config(message: "Khong the thay doi cau hinh sau khi khoi tao")
                
            case let (nil, c?):
                instance = SharedInstance(config: c)
                return instance
                
            default:
                instance = SharedInstance(config: UIView())
                return instance
            }
        }
    }
    
    // WAY 2
    class var sharedInstance: LoginCell {
        struct Singleton {
            static let instance = LoginCell()
        }
        
        return Singleton.instance
    }
// ### END
    
    private var view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (view: UIView) {
        self.init()
        self.view = view
        self.setupLayouts()
    }
    
}

extension LoginCell {
    
    func setupLayouts() {
        
        let w = UIScreen.mainScreen().bounds.width - 50
        
        let viewUsername = UIView()
        let viewPassword = UIView()
        
        self.view.addSubview(scrollView)
        self.view.addSubview(lbAnsv)
        self.view.addSubview(lbTime)
        self.view.addConstraintsViaFormat("H:|-30-[v0]-30-|", views: lbAnsv)
        self.view.addConstraintsViaFormat("H:|-30-[v0]-30-|", views: lbTime)
        self.view.addConstraintsViaFormat("H:|[v0]|", views: scrollView)
        self.view.addConstraintsViaFormat("V:[v0]-3-[v1]-5-|", views: lbAnsv, lbTime)
        self.view.addConstraintsViaFormat("V:|[v0]|", views: scrollView)
        
        scrollView.addSubview(lbBts)
        scrollView.addSubview(btnLogin)
        scrollView.addSubview(viewUsername)
        scrollView.addSubview(viewPassword)
        
        scrollView.addConstraintsViaFormat("H:[v0]", views: lbBts)
        scrollView.addConstraintsViaFormat("H:[v0(\(w))]", views: viewUsername)
        scrollView.addConstraintsViaFormat("H:[v0(\(w))]", views: viewPassword)
        scrollView.addConstraintsViaFormat("H:[v0(\(w))]", views: btnLogin)
        scrollView.addConstraintsViaFormat("V:[v0(50)]-20-[v1(50)]-30-[v2(45)]", views: viewUsername, viewPassword, btnLogin)
        scrollView.addConstraintsViaFormat("V:[v0(110)]-40-[v1]", views: lbBts, viewUsername)
        
        // SET HOR
        scrollView.addSubview(horUsername)
        scrollView.addSubview(horPassword)
        scrollView.addConstraintsViaFormat("H:[v0(\(w-70))]", views: horUsername)
        scrollView.addConstraintsViaFormat("H:[v0(\(w-70))]", views: horPassword)
        scrollView.addConstraintsViaFormat("V:[v0]-5-[v1(0.5)]", views: viewUsername, horUsername)
        scrollView.addConstraintsViaFormat("V:[v0]-5-[v1(0.5)]", views: viewPassword, horPassword)
        
        // USERNAME & EMAIL
        viewUsername.addSubview(imgUsername)
        viewUsername.addSubview(lbUsername)
        viewUsername.addSubview(tfUsername)
        
        viewUsername.addConstraintsViaFormat("H:|[v0(50)]-20-[v1]|", views: imgUsername, lbUsername)
        viewUsername.addConstraintsViaFormat("H:|[v0(50)]-20-[v1]|", views: imgUsername, tfUsername)
        viewUsername.addConstraintsViaFormat("V:|[v0(50)]", views: imgUsername)
        viewUsername.addConstraintsViaFormat("V:|[v0(16)]-7-[v1(27)]", views: lbUsername, tfUsername)
        
        // PASSWORD
        viewPassword.addSubview(imgPassword)
        viewPassword.addSubview(lbPassword)
        viewPassword.addSubview(tfPassword)
        
        viewPassword.addConstraintsViaFormat("H:|[v0(50)]-20-[v1]|", views: imgPassword, lbPassword)
        viewPassword.addConstraintsViaFormat("H:|[v0(50)]-20-[v1]|", views: imgPassword, tfPassword)
        viewPassword.addConstraintsViaFormat("V:|[v0(50)]", views: imgPassword)
        viewPassword.addConstraintsViaFormat("V:|[v0(16)]-7-[v1(27)]", views: lbPassword, tfPassword)
        
        // BTS
        scrollView.addConstraint(NSLayoutConstraint(item: lbBts, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView.self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        // HOR
        scrollView.addConstraint(NSLayoutConstraint(item: horUsername, attribute: .Right, relatedBy: .Equal, toItem: viewUsername.self, attribute: .Right, multiplier: 1, constant: 0))
        
        scrollView.addConstraint(NSLayoutConstraint(item: horPassword, attribute: .Right, relatedBy: .Equal, toItem: viewUsername.self, attribute: .Right, multiplier: 1, constant: 0))
        
        // SIGN BUTTON
        scrollView.addConstraint(NSLayoutConstraint(item: btnLogin, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView.self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        // VIEW USERNAME
        scrollView.addConstraint(NSLayoutConstraint(item: viewUsername, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView.self, attribute: .CenterX, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: viewUsername, attribute: .CenterY, relatedBy: .Equal, toItem: scrollView.self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        // VIEW PASSWORD
        scrollView.addConstraint(NSLayoutConstraint(item: viewPassword, attribute: .CenterX, relatedBy: .Equal, toItem: scrollView.self, attribute: .CenterX, multiplier: 1, constant: 0))
        
    }

    
}
