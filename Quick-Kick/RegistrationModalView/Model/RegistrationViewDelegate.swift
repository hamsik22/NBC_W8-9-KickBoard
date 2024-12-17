//
//  RegistrationViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    
    func activateButton(type: Bool?, nickName: Bool?, location: Bool?)
    
}
