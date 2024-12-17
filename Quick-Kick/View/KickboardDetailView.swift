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
        view.layer.cornerRadius = 20
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
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(contentContainerView)
        
        // Auto Layout
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            // Content Container
            contentContainerView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 20),
            contentContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentContainerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with items: [String]) {
        contentContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        var previousView: UIView? = nil
        
        for item in items {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
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
            contentContainerView.addSubview(containerView)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                
                containerView.heightAnchor.constraint(equalToConstant: 70),
                containerView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor)
            ])
            
            if let previous = previousView {
                containerView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                containerView.topAnchor.constraint(equalTo: contentContainerView.topAnchor).isActive = true
            }
            
            previousView = containerView
        }
        
        previousView?.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -10).isActive = true
    }
}
