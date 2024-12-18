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
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        setupLayout()
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
        
        confermPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(25)
            make.width.equalTo(logoImageView.snp.width)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        confermPasswordField.isSecureTextEntry = true
        
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
        if isValidUser() {
            if let email = emailField.text, let password = passwordField.text {
                delegate?.didSignupButtonTapped(email, pass: password)
            }
        }
    }
    
    // 입력값이 유효한지 검증하는 함수
    private func isValidUser() -> Bool {
        // case0. 비어있는 값이 있을 경우
        guard ((emailField.text?.isEmpty) != nil) ||
            ((passwordField.text?.isEmpty) != nil) ||
            ((confermPasswordField.text?.isEmpty) != nil) else {
            print("입력값을 확인해주세요")
            return false
        }
    
        if passwordField.text != confermPasswordField.text {
            // case1. 2개의 비밀번호 입력값이 상이한 경우
            print("비밀번호가 다릅니다")
            return false
        }
        // TODO: case2. 이미 존재하는 이메일인 경우
        else { return true }
    }
}
// MARK: - Protocol
protocol SignUpViewDelegate: AnyObject {
    func didSignupButtonTapped(_ email: String, pass: String)
}
@available(iOS 17.0, *)
#Preview {
    return SignUpViewController()
}
