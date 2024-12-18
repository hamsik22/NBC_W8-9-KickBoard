//
//  ProfileView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1) // 연한 보라색 네모
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let purpleCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple // 진한 보라색 원
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "kickboard")) // Asset에 추가된 킥보드 이미지
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .systemPurple
        label.text = "User1" // 기본 닉네임
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "user1234@gmail.com"
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
        addSubview(containerView)
        containerView.addSubview(purpleCircleView)
        containerView.addSubview(kickboardImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(editIconImageView)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            // Purple Circle
            purpleCircleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            purpleCircleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            purpleCircleView.widthAnchor.constraint(equalToConstant: 100),
            purpleCircleView.heightAnchor.constraint(equalToConstant: 100),
            
            // Kickboard Image
            kickboardImageView.centerYAnchor.constraint(equalTo: purpleCircleView.centerYAnchor),
            kickboardImageView.centerXAnchor.constraint(equalTo: purpleCircleView.centerXAnchor),
            kickboardImageView.widthAnchor.constraint(equalToConstant: 80),
            kickboardImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: purpleCircleView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: purpleCircleView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: editIconImageView.leadingAnchor, constant: -10),
            
            // Email Label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            // Edit Icon
            editIconImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            editIconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            editIconImageView.widthAnchor.constraint(equalToConstant: 20),
            editIconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(name: String = "User1", email: String = "user1234@gmail.com") {
        nameLabel.text = name
        emailLabel.text = email
    }
    
    // MARK: - Edit Name Gesture
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editNameTapped))
        editIconImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func editNameTapped() {
        guard let viewController = findViewController() else { return }
        
        let alert = UIAlertController(title: "닉네임 수정", message: "새로운 닉네임을 입력하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.nameLabel.text
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self?.nameLabel.text = newName
                self?.onNameChange?(newName)
            }
        })
        viewController.present(alert, animated: true)
    }
    
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
