//
//  LoginView.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/17/24.
//

import UIKit
import SnapKit
import SwiftUI

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo_WhiteBG")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField : UITextField = {
        let field = UITextField().setCustomPlaceholder(placeholder: "이메일")
        return field
    }()
    private let passwordField = UITextField().setCustomPlaceholder(placeholder: "비밀번호")
    
    // TODO: 커스텀 뷰로 수정 checkboxButton
    private let rememberIDOption: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 저장", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        return button
    }()
    // TODO: 커스텀 뷰로 수정 checkboxButton
    @objc private let autoLoginOption: UIButton = {
        let button = UIButton()
        button.setTitle("자동 로그인", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        return button
    }()
    private let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호를 잊어버렸습니까?", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        return button
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.PersonalNomal.nomal
        button.layer.cornerRadius = 20
        return button
    }()
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.PersonalLight.light
        button.layer.cornerRadius = 20
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        settingActions()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [logoImageView, emailField, passwordField, autoLoginOption, rememberIDOption, findPasswordButton, loginButton, signupButton]
            .forEach{ addSubview($0) }
        layout()
    }
    
    private func layout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            // 사이즈가 조금 이상한가봐요
            make.centerX.equalToSuperview().offset(-15)
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        autoLoginOption.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(passwordField.snp.left)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        rememberIDOption.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(autoLoginOption.snp.right).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(autoLoginOption.snp.bottom).offset(10)
            make.left.equalTo(passwordField.snp.left)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(findPasswordButton.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}

extension UITextField {
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
}

struct LoginViewPreview: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}

protocol LoginViewDelegate: AnyObject {
    func didAutoLoginOptionTapped()
    func didRememberIDOptionTapped()
    func didFindPasswordButtonTapped()
    func didLoginButtonTapped()
    func didSignupButtonTapped()
}

extension LoginView {
    private func settingActions() {
        autoLoginOption.addTarget(self, action: #selector(autoLoginOptionTapped), for: .touchUpInside)
        rememberIDOption.addTarget(self, action: #selector(rememberIDOptionTapped), for: .touchUpInside)
        findPasswordButton.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc func autoLoginOptionTapped() {
        delegate?.didAutoLoginOptionTapped()
    }
    @objc func rememberIDOptionTapped() {
        delegate?.didRememberIDOptionTapped()
    }
    @objc func findPasswordButtonTapped() {
        delegate?.didFindPasswordButtonTapped()
    }
    @objc func loginButtonTapped() {
        delegate?.didLoginButtonTapped()
    }
    @objc func signupButtonTapped() {
        delegate?.didSignupButtonTapped()
    }
}
