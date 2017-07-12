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
        iv.layer.cornerRadius = 1
        iv.layer.masksToBounds = true
        return iv
    
    }()
    
    let sensorName: UILabel = {

        let lb = UILabel()
        lb.text = "MOTION"
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_COMMON_BOLD, size: 17.0)
        lb.textAlignment = .Left
        return lb
    
    }()
    
    
    let messageSensor: UILabel = {

        let lb = UILabel()
        lb.text = "HAVE ACTION"
        lb.textColor = UIColor.whiteColor()
        lb.font = UIFont(name: SaveText.FONT_OF_COMMON, size: 16.0)
        lb.textAlignment = .Left
        return lb
    
    }()
    
    let request: Alamofire.Request? = nil
    
    override func setupViews() {
        let container = UIView()
        
        addSubview(container)
        
        addConstraintsViaFormat("H:|[v0]|", views: container)
        addConstraintsViaFormat("V:[v0(50)]", views: container)
        addConstraint(NSLayoutConstraint(item: container, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

        container.addSubview(imageView)
        container.addSubview(sensorName)
        container.addSubview(messageSensor)
        container.addConstraintsViaFormat("H:|-10-[v0(50)]-10-[v1]-5-|", views: imageView, sensorName)
        container.addConstraintsViaFormat("H:|-10-[v0(50)]-10-[v1]-5-|", views: imageView, messageSensor)

        container.addConstraintsViaFormat("V:|[v0(50)]|", views: imageView)
        container.addConstraintsViaFormat("V:|-3-[v0(20)]", views: sensorName)
        container.addConstraintsViaFormat("V:[v0(20)]-3-|", views: messageSensor)
    }
    
    func updateCell(sensorName: String, dateTime: String) {
        
        self.sensorName.text = sensorName
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let stringFormat = (dateFormatter.dateFromString(dateTime))!
        let dayFormat = NSDateFormatter()
        let timeFormat = NSDateFormatter()
        dayFormat.dateFormat = "d/MM/yyyy"
        timeFormat.dateFormat = "HH:mm:ss"
        dayFormat.timeZone = NSTimeZone(name: "UTC")
        timeFormat.timeZone = NSTimeZone(name: "UTC")
        
        self.messageSensor.text = "vào lúc \(timeFormat.stringFromDate(stringFormat)), ngày \(dayFormat.stringFromDate(stringFormat))"
        
    }
    
}
