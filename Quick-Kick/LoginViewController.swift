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
    
    private let appLogoImageView = UIImageView()
    private let authOptionView: UIView = {
        let view = UIView()
        return view
    }()
    private let loginButtonView: UIView = {
        let view = UIView()
        return view
    }()
    let loginFieldView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: UI 세팅하기
        setupUI()
    }
    
    // TODO: UI 세팅 함수
    private func setupUI() {
        
        [appLogoImageView,
         loginFieldView,
         authOptionView,
         loginButtonView]
            .forEach{ view.addSubview($0) }
        
        setupLoginFieldView()
        setupAuthOptionView()
        setupLoginButtonView()
        
        appLogoImageView.image = UIImage(systemName: "person.circle")
        appLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 250, height: 250))
        }
        
        loginFieldView.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        authOptionView.snp.makeConstraints { make in
            make.top.equalTo(loginFieldView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(70)
        }
        
        loginButtonView.snp.makeConstraints { make in
            make.top.equalTo(authOptionView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
    }
}

extension LoginViewController {
    private func setupLoginFieldView() {
        let emailTextField = UITextField()
        let passwordTextField = UITextField()
        
        emailTextField.placeholder = "이메일"
        passwordTextField.placeholder = "비밀번호"
        
        emailTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        emailTextField.backgroundColor = .systemBackground
        passwordTextField.backgroundColor = .systemBackground
        
        [emailTextField, passwordTextField]
            .forEach{loginFieldView.addSubview($0)}
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    private func setupAuthOptionView() {
        let saveId = UIView()
        let saveIDLable: UILabel = {
            let label = UILabel()
            label.text = "아이디 저장"
            label.font = .systemFont(ofSize: 15)
            return label
        }()
        let idSavecheckBox: UIImageView = {
            let icon = UIImageView()
            icon.image = UIImage(systemName: "checkmark.square")
            icon.contentMode = .scaleAspectFit
            return icon
        }()
        let autoLogIn = UIView()
        let autoLogInLable: UILabel = {
            let label = UILabel()
            label.text = "자동 로그인"
            label.font = .systemFont(ofSize: 15)
            return label
        }()
        let autoLogincheckBox: UIImageView = {
            let icon = UIImageView()
            icon.image = UIImage(systemName: "checkmark.square")
            icon.contentMode = .scaleAspectFit
            return icon
        }()
        let findPasswordButton: UIButton = {
            let button = UIButton()
            button.setTitle("비밀번호를 잊어버렸습니까?", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.setTitleColor(.black, for: .normal)
            return button
        }()
        
        [saveIDLable, idSavecheckBox]
            .forEach{ saveId.addSubview($0) }
        
        saveIDLable.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
        }
        
        idSavecheckBox.snp.makeConstraints { make in
            make.left.equalTo(saveIDLable.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        [autoLogInLable, autoLogincheckBox]
            .forEach{ autoLogIn.addSubview($0) }
        autoLogInLable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        autoLogincheckBox.snp.makeConstraints { make in
            make.left.equalTo(autoLogInLable.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        
        [saveId, autoLogIn, findPasswordButton]
            .forEach{authOptionView.addSubview($0)}
        
        saveId.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.right.equalToSuperview()
        }
        autoLogIn.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.left.equalTo(saveId.snp.right).offset(5)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(saveId.snp.bottom).offset(10)
            make.left.equalToSuperview()
        }
    }
    private func setupLoginButtonView() {
        let loginButton: UIButton = {
            let button = UIButton()
            button.setTitle("로그인", for: .normal)
            button.backgroundColor = .purple
            button.layer.cornerRadius = 25
            return button
        }()
        let signupButton: UIButton = {
            let button = UIButton()
            button.setTitle("회원가입", for: .normal)
            button.backgroundColor = .purple
            button.layer.cornerRadius = 25
            return button
        }()
        
        [loginButton, signupButton]
            .forEach{ loginButtonView.addSubview($0) }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
}

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
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
