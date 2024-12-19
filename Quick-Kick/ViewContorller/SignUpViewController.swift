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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Delegate
extension SignUpViewController: SignUpViewDelegate {
    func didSignupButtonTapped(_ email: String, pass: String) {
        UserDefaultsManager.shared.saveUser(User(email: email, password: pass))
        if let targetVC = navigationController?.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController?.popToViewController(targetVC, animated: true)
        } else {
            print("이동할 LoginViewController가 스택에 없음")
        }
    }
}
// MARK: - Function
extension SignUpViewController {
    // 키보드 내리기
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}
