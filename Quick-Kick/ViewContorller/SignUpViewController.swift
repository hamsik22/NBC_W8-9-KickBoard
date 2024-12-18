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
        view.backgroundColor = .white
    }
}

extension SignUpViewController: SignUpViewDelegate {
    func didSignupButtonTapped(_ email: String, pass: String) {
        if let targetVC = navigationController?.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController?.popToViewController(targetVC, animated: true)
        } else {
            print("이동할 LoginViewController가 스택에 없음")
        }
        print("email : \(email), pass : \(pass)")
        print("정보 저장하기")
        print("로그인 화면으로 이동하기")
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}
