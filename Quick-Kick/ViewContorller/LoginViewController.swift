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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTextFields()
        processAuthOption()
    }
    
    override func loadView() {
        view = loginView
        loginView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        printUserInfoStatus()
        processAuthOption()
    }
    
}

// MARK: - Delegates
extension LoginViewController: LoginViewDelegate {
    // 회원가입 화면에서 돌아왔을 때, 텍스트필드 초기화
    func initTextFields() {
        loginView.initTextFields()
    }
    
    // 로그인 버튼 터치 시
    func didLoginButtonTapped(_ email: String, _ password: String) {
        if isCorrectInfo(email: email, password: password) {
            login()
        } else {
            print("로그인 실패")
        }
    }
    
    // 자동 로그인 옵션 터치 시
    func didAutoLoginOptionTapped() {
        loginView.autoLoginCheckBoxIsChecked.toggle()
        if loginView.autoLoginCheckBoxIsChecked {
            UserDefaultsManager.shared.autoLoginOption = true
        } else {
            UserDefaultsManager.shared.autoLoginOption = false
        }
    }
    
    // 아이디 저장 옵션 터치 시
    func didRememberIDOptionTapped(_ textField: UITextField) {
        loginView.rememberIDCheckBoxIsChecked.toggle()
        if loginView.rememberIDCheckBoxIsChecked {
            UserDefaultsManager.shared.rememberIDOption = true
        } else {
            UserDefaultsManager.shared.rememberIDOption = false
        }
    }
    
    // 아이디 저장 옵션 시, 동작할 함수
    func getEmailTextField() {
        guard let user = UserDefaultsManager.shared.getUser() else { return }
        loginView.setEmailFieldText(email: user.email)
    }
    
    // 회원가입 버튼 터치 시
    func didSignUpButtonTapped() {
        print("회원가입 화면으로 이동")
        let signUpVC = SignUpViewController()
        signUpVC.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
// MARK: - Functions
extension LoginViewController {
    // 저장되어 있는 데이터들을 출력하는 함수
    private func printUserInfoStatus() {
        if let user = UserDefaultsManager.shared.getUser() {
            print("현재 유저정보")
            print("EMail: \(user.email)\nPassWord: \(user.password)\nNickName: \(user.nickName)")
        }
        print("로그인상태 : \(UserDefaultsManager.shared.isLoggedIn)")
        print("아이디저장 : \(UserDefaultsManager.shared.rememberIDOption)")
        print("자동로그인 : \(UserDefaultsManager.shared.autoLoginOption)")
    }
    
    // 로그인 정보를 확인하는 함수
    private func isCorrectInfo(email: String?, password: String?) -> Bool {
        guard let email, let password else {
            print("정보를 입력해주세요")
            return false }
        guard let user = UserDefaultsManager.shared.getUser() else { return false }
        if email == user.email && password == user.password {
            return true
        } else {
            return false
        }
    }
    // 로그인 시 동작할 함수
    private func login() {
        // TODO: 로그인 후 화면으로 가야해요
        UserDefaultsManager.shared.isLoggedIn = true
        print("로그인 성공 : 다음 동작을 정의해야해요!")
    }
    // 로그인 옵션에 따라 동작하는 함수
    private func processAuthOption() {
        guard let _ = UserDefaultsManager.shared.getUser() else { return }
            if UserDefaultsManager.shared.isLoggedIn {
                login()
            } else if UserDefaultsManager.shared.autoLoginOption {
                login()
            }
            if UserDefaultsManager.shared.rememberIDOption && !UserDefaultsManager.shared.isLoggedIn {
                getEmailTextField()
            }
    }
}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: LoginViewController())
}
