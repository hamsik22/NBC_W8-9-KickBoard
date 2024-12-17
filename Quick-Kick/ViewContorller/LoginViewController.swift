//
//  LoginViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/16/24.
//

import UIKit
import SwiftUI
import SnapKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    var delegate : LoginViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loginView.delegate = self
    }
    
    private func setup() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
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

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

// 프리뷰
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
