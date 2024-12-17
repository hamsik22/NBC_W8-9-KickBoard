//
//  AddKickboardViewController.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit

class AddKickboardViewController: UIViewController, ModalViewDelegate {
    
    private lazy var containerView: AddKickboardView = .init()
        
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.modalViewDelegate = self
    }
    
}
