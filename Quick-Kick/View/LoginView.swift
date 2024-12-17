//
//  LoginView.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/17/24.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppLogo_WhiteBG")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailField = UITextField().setCustomPlaceholder(placeholder: "이메일")
    private let passwordField = UITextField().setCustomPlaceholder(placeholder: "비밀번호")
    
    private let rememberIDOption: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 저장", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        return button
    }()
    private let rememberIDCheckBox: UIImageView = {
        let image = UIImage(systemName: "square")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.PersonalLight.active
        return imageView
    }()
    private let autoLoginOption: UIButton = {
        let button = UIButton()
        button.setTitle("자동 로그인", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        return button
    }()
    private lazy var autoLoginCheckBox: UIImageView = {
        let image = UIImage(systemName: "square")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.PersonalLight.active
        return imageView
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
    var autoLoginCheckBoxIsChecked: Bool = false {
        didSet {
            autoLoginCheckBox.image = UIImage(systemName: autoLoginCheckBoxIsChecked ? "checkmark.square" : "square")
            print("자동 로그인 상태: \(autoLoginCheckBoxIsChecked)")
        }
    }
    var rememberIDCheckBoxIsChecked: Bool = false {
        didSet {
            rememberIDCheckBox.image = UIImage(systemName: rememberIDCheckBoxIsChecked ? "checkmark.square" : "square")
            print("아이디 저장 상태: \(rememberIDCheckBoxIsChecked)")
        }
    }
    
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
        [logoImageView, emailField, passwordField, rememberIDCheckBox, autoLoginOption, autoLoginCheckBox, rememberIDOption, findPasswordButton, loginButton, signupButton]
            .forEach{ addSubview($0) }
        layout()
    }
    
    private func layout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview().offset(-15)// 중앙에 딱 안맞아서 offset으로 조절했어요!
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
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        autoLoginCheckBox.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(autoLoginOption.snp.right)
            make.size.equalTo(20)
        }
        
        rememberIDCheckBox.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(rememberIDOption.snp.right)
            make.size.equalTo(20)
        }
        
        rememberIDOption.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(autoLoginCheckBox.snp.right)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(autoLoginOption.snp.bottom).offset(10)
            make.left.equalTo(passwordField.snp.left)
            make.width.equalTo(140)
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

@available(iOS 17.0, *)
#Preview {
    LoginViewController()
}