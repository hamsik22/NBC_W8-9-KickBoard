//
//  KickboardDetailView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardDetailView: UIView {
    
    // MARK: - UI Components
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 상세정보"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let kickboardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        return stackView
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        backgroundColor = .white
        
        // Add components
        addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        addSubview(backButton)
        addSubview(kickboardStackView)
        
        // Auto Layout
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        kickboardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            // Title Container
            titleContainerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            titleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            
            // Kickboard Stack View
            kickboardStackView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 20),
            kickboardStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            kickboardStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            kickboardStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Public Methods
    
    func configure(with items: [String]) {
        kickboardStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in items {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 10
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 1
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOpacity = 0.2
            containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.text = item
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            ])
            
            kickboardStackView.addArrangedSubview(containerView)
            containerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
    }
}
