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
        imageView.tintColor = UIColor.PersonalNomal.nomal
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
        imageView.tintColor = UIColor.PersonalNomal.nomal
        return imageView
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
    
    // 체크박스 상태변수
    var autoLoginCheckBoxIsChecked: Bool = UserDefaultsManager.shared.autoLoginOption {
        didSet {
            autoLoginCheckBox.image = UIImage(systemName: autoLoginCheckBoxIsChecked ? "checkmark.square.fill" : "square")
            UserDefaults.standard.set(autoLoginCheckBoxIsChecked, forKey: "autoLoginCheckBoxIsChecked")
        }
    }
    var rememberIDCheckBoxIsChecked: Bool = UserDefaultsManager.shared.rememberIDOption {
        didSet {
            rememberIDCheckBox.image = UIImage(systemName: rememberIDCheckBoxIsChecked ? "checkmark.square.fill" : "square")
            UserDefaults.standard.set(rememberIDCheckBoxIsChecked, forKey: "rememberIDCheckBoxIsChecked")
        }
    }
    

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        settingActions()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension LoginView {
    private func setupSubviews() {
        [logoImageView, emailField, passwordField, rememberIDCheckBox, autoLoginOption, autoLoginCheckBox, rememberIDOption, loginButton, signupButton]
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
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .none
                
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
        autoLoginCheckBox.image = UIImage(systemName: autoLoginCheckBoxIsChecked ? "checkmark.square.fill" : "square")
        
        rememberIDCheckBox.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(rememberIDOption.snp.right)
            make.size.equalTo(20)
        }
        rememberIDCheckBox.image = UIImage(systemName: rememberIDCheckBoxIsChecked ? "checkmark.square.fill" : "square")
        
        rememberIDOption.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalTo(autoLoginCheckBox.snp.right)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(rememberIDOption.snp.bottom).offset(100)
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
// MARK: - Functions
extension LoginView {
    // 버튼 타겟추가
    private func settingActions() {
        autoLoginOption.addTarget(self, action: #selector(autoLoginOptionTapped), for: .touchUpInside)
        rememberIDOption.addTarget(self, action: #selector(rememberIDOptionTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    // 아이디 저장 옵션에 필요한 함수
    func setEmailFieldText(email: String) {
        emailField.text = email
    }
    // 화면 이동 시, 텍스트필드 초기화
    func initTextFields() {
        emailField.text = ""
        passwordField.text = ""
    }
    
    // 자동 로그인 터치
    @objc func autoLoginOptionTapped() {
        delegate?.didAutoLoginOptionTapped()
    }
    // 아이디 저장 터치
    @objc func rememberIDOptionTapped() {
        delegate?.didRememberIDOptionTapped(emailField)
    }
    // 로그인 버튼 터치
    @objc func loginButtonTapped() {
        if let email = emailField.text, let password = passwordField.text {
            delegate?.didLoginButtonTapped(email, password)
        }
        DispatchQueue.main.async {
            UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve) {
                self.window?.rootViewController = UINavigationController(rootViewController: OnboardingPageViewController())
            }
        }
    }
    // 회원가입 터치
    @objc func signupButtonTapped() {
        delegate?.didSignUpButtonTapped()
    }
    // 텍스트 필드가 비어있는지 확인
    private func isTextFieldsEmpty() -> Bool {
        // 비어있는 값이 있을 경우
        guard ((emailField.text?.isEmpty) != nil) ||
            ((passwordField.text?.isEmpty) != nil)else {
            print("정보를 입력해주세요")
            return false
        }
        return true
    }
}
// MARK: - Protocol
protocol LoginViewDelegate: AnyObject {
    func didAutoLoginOptionTapped()
    func didRememberIDOptionTapped(_ textField: UITextField)
    func didLoginButtonTapped(_ email: String, _ password: String)
    func didSignUpButtonTapped()
    func getEmailTextField()
    func initTextFields()
}

// Preview
@available(iOS 17.0, *)
#Preview {
    LoginViewController()
}
