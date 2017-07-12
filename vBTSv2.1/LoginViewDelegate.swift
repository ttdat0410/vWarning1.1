//
//  LoginViewDelegate.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

//######## PROTOCOL FOR LOGIN VIEW ##########
protocol LoginViewDelegate {
    
    func showErrors(status: StatusLogin)
    func showKeyboard()
    func hiddenKeyboard()
}

