//
//  BaseCell.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/11/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
}
