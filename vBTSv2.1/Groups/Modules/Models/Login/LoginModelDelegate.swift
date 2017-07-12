//
//  LoginModelPresenter.swift
//  vBTSv2.1
//
//  Created by DatTran on 7/7/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

typealias LoginCallBack = ((complete: StatusCode)->(Void))?

protocol LoginModelDelegate {
    func exeLoginRequest(username: String, password: String, complete: LoginCallBack)
}
