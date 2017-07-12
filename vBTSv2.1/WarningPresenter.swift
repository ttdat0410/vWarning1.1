//
//  WarningPresenter.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class WarningPresenter: NSObject {
    
    private
    var model: WarningModelDelegate = WarningModel()
    var view: WarningViewDelegate = WarningViewController()
    
    override init () {
        super.init()
    }
    
    convenience init (model: WarningModelDelegate, view: WarningViewDelegate) {
        
        self.init()
        self.model = model
        self.view = view
        
    }
    
    func displayViewFromWarningModel() {
        
        self.view.displayWarning(self.model.getWarning())
        
    }
    
}
