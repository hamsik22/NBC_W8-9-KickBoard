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
        navigationItem.hidesBackButton = true
    }
}

extension LoginViewController: LoginViewDelegate {
    func didLoginButtonTapped(_ email: String, _ password: String) {
        print("email : \(email), pass : \(password)\n로그인 성공")
    }
    
    func didAutoLoginOptionTapped() {
        print("로그인 이력이 있으면 자동으로 최근 이메일 기준으로 로그인")
        loginView.autoLoginCheckBoxIsChecked.toggle()
    }
    
    func didRememberIDOptionTapped() {
        print("로그인 성공 후 이메일 지속 표시")
        loginView.rememberIDCheckBoxIsChecked.toggle()
    }
    
    func didSignUpButtonTapped() {
        print("회원가입 화면으로 이동")
        let signUpVC = SignUpViewController()
        signUpVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(signUpVC, animated: true)
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
    UINavigationController(rootViewController: LoginViewController())
    
}
