//
//  ProfileView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - UI Components
    
    private let backgroundCircleView: UIView = { // 보라색 원
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40 // 원의 크기
        return view
    }()
    
    private let profileImageView: UIImageView = { // 킥보드 이미지
        let imageView = UIImageView()
        imageView.image = UIImage(named: "QuickBoard")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.systemPurple
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "user1234@gmail.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemPurple
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            // 보라색 원 (킥보드 이미지 중앙에서 약간 좌측으로 조정)
            backgroundCircleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundCircleView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor, constant: -15), // 약간 좌측
            backgroundCircleView.widthAnchor.constraint(equalToConstant: 80),
            backgroundCircleView.heightAnchor.constraint(equalToConstant: 80),
            
            // 킥보드 이미지 (오른쪽으로 이동)
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40), // 오른쪽으로 이동
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            // 이름 Label
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: profileImageView.trailingAnchor, constant: 10),
            
            // 이메일 Label
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: profileImageView.trailingAnchor, constant: 10),
            
            // Profile View 크기 조정
            self.heightAnchor.constraint(equalToConstant: 120),
            self.leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? self.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? self.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure
    
    func configure(name: String, email: String, imageName: String) {
        nameLabel.text = name
        emailLabel.text = email
        profileImageView.image = UIImage(named: imageName)
    }
}
