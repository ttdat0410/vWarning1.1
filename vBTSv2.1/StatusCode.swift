//
//  StatusCode.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/10/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//


enum StatusCode: Int {
    
    case DEFAULT = 0
    case SUCCESS = 1
    case USERSER_OR_PASSWORD_IS_INCORRECT = 9
    case FAILURE = 0x07
    
    case ADMIN      = 505
    case OPERATOR   = 515
    
}