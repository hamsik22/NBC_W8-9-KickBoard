//
//  LoginViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/16/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    var delegate : LoginViewDelegate?
    
    override func loadView() {
        view = loginView
        loginView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: LoginViewDelegate {
    func didAutoLoginOptionTapped() {
        print("자동 로그인 버튼")
    }
    
    func didRememberIDOptionTapped() {
        print("아이디 저장 버튼")
    }
    
    func didFindPasswordButtonTapped() {
        print("비밀번호 찾기 버튼")
    }
    
    func didLoginButtonTapped() {
        print("로그인 버튼")
    }
    
    func didSignupButtonTapped() {
        print("회원가입 버튼")
    }
}
    
extension UITextField {
    
    // UITextField 색깔 변경 하는 함수
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}

@available(iOS 17.0, *)
#Preview {
    LoginViewController()
}
