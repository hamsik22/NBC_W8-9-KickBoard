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
        if let user = UserDefaultsManager.shared.getUser() {
            print("현재 유저정보")
            print("EMail: \(user.email)\nPassWord: \(user.password)\nNickName: \(user.nickName)")
        }
    }
}

// MARK: - Delegates
extension LoginViewController: LoginViewDelegate {
    func didLoginButtonTapped(_ email: String, _ password: String) {
        if isCorrectInfo(email: email, password: password) {
            login()
        } else {
            print("로그인 실패")
        }
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
// MARK: - Functions
extension LoginViewController {
    private func isCorrectInfo(email: String, password: String) -> Bool {
        if let user = UserDefaultsManager.shared.getUser() {
            if email == user.email && password == user.password {
                return true
            } else {
                print("유저 정보가 일치하지 않아요! 다시 입력하세요!")
                return false
            }
        } else {
            print("가입된 유저가 없습니다.")
            return false
        }
    }
    
    private func login() {
        print("로그인 성공 : 행동을 추가해주세요")
    }
}
// MARK: - Extension
extension UITextField {
    /// UITextField의 UI 세팅을 위한 함수
    func setCustomPlaceholder(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 14)
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.PersonalLight.light
        tf.setPlaceholder(color: UIColor.PersonalLight.active)
        tf.layer.cornerRadius = 10
        return tf
    }
    /// UITextField 색깔 변경 하는 함수
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
