//
//  SignUpViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/16/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()

    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}
