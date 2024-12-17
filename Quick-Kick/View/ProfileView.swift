//
//  ProfileView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - UI Components
    private let backgroundCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40 // 원의 반지름
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.systemPurple
        label.textAlignment = .right // 우측 정렬
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemPurple
        label.textAlignment = .right // 우측 정렬
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pencil"))
        imageView.tintColor = .systemPurple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Callback
    var onNameChange: ((String) -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
        layer.cornerRadius = 20
        
        addSubview(backgroundCircleView)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(editIconImageView)
        
        NSLayoutConstraint.activate([
            // 보라색 원 (킥보드 중앙 기준 좌측으로 이동)
            backgroundCircleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundCircleView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor, constant: -15), // 좌측 치우침
            backgroundCircleView.widthAnchor.constraint(equalToConstant: 80),
            backgroundCircleView.heightAnchor.constraint(equalToConstant: 80),
            
            // 프로필 이미지 (킥보드 위치 조금 우측으로 조정)
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            // 이름 레이블 (오른쪽으로 살짝 조정)
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 30), // 오른쪽 여백 추가
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            // 수정 아이콘
            editIconImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            editIconImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            editIconImageView.widthAnchor.constraint(equalToConstant: 20),
            editIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // 이메일 레이블
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    // MARK: - Configure Method
    func configure(name: String, email: String, imageName: String) {
        nameLabel.text = name
        emailLabel.text = email
        profileImageView.image = UIImage(named: imageName)
    }
    
    // MARK: - Setup Gesture
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editNameTapped))
        editIconImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func editNameTapped() {
        showEditNameAlert()
    }
    
    // MARK: - Edit Name Alert
    private func showEditNameAlert() {
        guard let viewController = findViewController() else { return }
        
        let alert = UIAlertController(title: "닉네임 수정", message: "새로운 닉네임을 입력하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "닉네임"
            textField.text = self.nameLabel.text
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "저장", style: .default, handler: { [weak self] _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self?.nameLabel.text = newName
                self?.onNameChange?(newName)
            }
        }))
        viewController.present(alert, animated: true)
    }
    
    // MARK: - Helper
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let next = responder?.next {
            responder = next
            if let vc = responder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
