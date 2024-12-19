//
//  SignUpView.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/17/24.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate?
    
    var inputStatus: SignUpType? = nil {
        didSet {
            guard let inputStatus = inputStatus,
            let email = emailField.text,
            let password = passwordField.text
            else { return }
            delegate?.didSignupButtonTapped(email: email, pass: password, type: inputStatus)
        }
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo_WhiteBG")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailField = UITextField().setCustomPlaceholder(placeholder: "이메일")
    private let passwordField = UITextField().setCustomPlaceholder(placeholder: "비밀번호")
    private let confermPasswordField = UITextField().setCustomPlaceholder(placeholder: "비밀번호 확인")
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.PersonalNomal.nomal
        button.layer.cornerRadius = 20
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension SignUpView {
    private func addSubviews() {
        [logoImageView, emailField, passwordField, confermPasswordField, signUpButton]
            .forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview().offset(-15)// 중앙에 딱 안맞아서 offset으로 조절했어요!
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(-25)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(25)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .none
        
        confermPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(25)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        confermPasswordField.isSecureTextEntry = true
        confermPasswordField.textContentType = .none
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(confermPasswordField.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
// MARK: - Functions
extension SignUpView {
    
    // 회원가입 버튼이 눌렸을 때 동작
    @objc func signUpButtonTapped() {
        if isEmptyField() {
            inputStatus = .emptyInput
        } else if !isValidEmail() {
            inputStatus = .invalidEmail
        } else if !isValidPassword() {
            inputStatus = .invalidPassword
        } else if isInCorrectPassword() {
            inputStatus = .wrongConfirmPassword
        } else {
            inputStatus = .success
        }
    }
    
    // 비어있는 값이 있을 경우
    private func isEmptyField() -> Bool {
        return emailField.text?.isEmpty ?? true ||
               passwordField.text?.isEmpty ?? true ||
               confermPasswordField.text?.isEmpty ?? true
    }
    
    // 2개의 비밀번호 입력값이 상이한 경우
    private func isInCorrectPassword() -> Bool {
        return passwordField.text != confermPasswordField.text
    }
    
    private func isValidPassword() -> Bool {
        guard let password = passwordField.text, password.count >= 4 else { return false }
        guard let confirmPassword = confermPasswordField.text, confirmPassword.count >= 4 else { return false }
        return true
    }
    
    private func isValidEmail() -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: emailField.text)
    }
    
}
// MARK: - Protocol
protocol SignUpViewDelegate: AnyObject {
    func didSignupButtonTapped(email: String, pass: String, type: SignUpType)
}
@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}

enum SignUpType {
    case emptyInput
    case invalidEmail
    case invalidPassword
    case wrongConfirmPassword
    case success
}
