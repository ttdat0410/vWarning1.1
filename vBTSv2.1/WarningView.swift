//
//  WarningView.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit
import Alamofire

class WarningView: BaseCell {
    
    let imageView: UIImageView = {

        let iv = UIImageView()
        iv.image = UIImage(named: "ic_siren")
        iv.contentMode = .ScaleAspectFit
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    
    }()
    
    let request: Alamofire.Request? = nil
    
    override func setupViews() {
        
        addSubview(imageView)
        addConstraintsViaFormat("H:|-10-[v0(20)]", views: imageView)
        addConstraintsViaFormat("V:|-10-[v0(20)]", views: imageView)
        
        
    }
    
}
