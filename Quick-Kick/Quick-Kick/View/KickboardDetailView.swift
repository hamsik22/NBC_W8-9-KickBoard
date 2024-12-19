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
    
    private let contentContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            titleContainerView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            titleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            
            contentContainerView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 20),
            contentContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentContainerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with kickboard: Kickboard) {
        contentContainerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let details = [
            "닉네임: \(kickboard.nickName ?? "Unknown")",
            "안장형: \(kickboard.isSaddled ? "Yes" : "No")",
            "점유 상태: \(kickboard.isOccupied ? "사용 중" : "미사용")",
            "시작 시간: \(formattedDate(kickboard.startTime))",
            "종료 시간: \(formattedDate(kickboard.endTime))",
            "위도: \(kickboard.latitude)",
            "경도: \(kickboard.longitude)",
            "주소: \(kickboard.address ?? "No Address")"
        ]
        
        for detail in details {
            let label = UILabel()
            label.text = detail
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .darkGray
            label.numberOfLines = 0
            contentContainerView.addArrangedSubview(label)
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: date)
    }
}
