//
//  SignUpViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/16/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    var delegate: SignUpViewDelegate?

    override func loadView() {
        view = signUpView
        signUpView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func didSignupButtonTapped() {
        print("회원가입 완료")
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}
