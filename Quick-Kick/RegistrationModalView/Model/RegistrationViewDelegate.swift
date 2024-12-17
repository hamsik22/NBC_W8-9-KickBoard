//
//  RegistrationViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit

protocol RegistrationViewDelegate: AnyObject {
    
    var typeSeleted: Bool { get set }
    
    var haveNickNameText: Bool { get set }
    
    var haveLocationText: Bool { get set }
    
    func activateButton()
    
}
