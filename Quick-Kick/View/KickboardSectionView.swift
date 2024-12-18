//
//  KickboardSectionView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardSectionView: UIView {
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1) // 연한 보라색 배경
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 등록한 킥보드"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var kickboardViews: [UIView] = []
    private var onTap: ((Kickboard) -> Void)?
    private var kickboards: [Kickboard] = []

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
        addSubview(containerView)
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }

    // MARK: - Configure Method
    func configure(with kickboards: [Kickboard], imageSize: CGSize, onTap: @escaping (Kickboard) -> Void) {
        self.onTap = onTap
        self.kickboards = kickboards

        // 기존 뷰 제거
        kickboardViews.forEach { $0.removeFromSuperview() }
        kickboardViews.removeAll()

        var previousView: UIView?

        for (index, kickboard) in kickboards.enumerated() {
            let container = UIView()
            container.backgroundColor = .white
            container.layer.cornerRadius = 20
            container.layer.borderColor = UIColor.systemPurple.cgColor
            container.layer.borderWidth = 1
            container.translatesAutoresizingMaskIntoConstraints = false
            container.tag = index
            
            let imageView = UIImageView(image: UIImage(named: kickboard.isSaddled ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let nicknameLabel = UILabel()
            nicknameLabel.text = kickboard.nickName
            nicknameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            nicknameLabel.textColor = .systemPurple
            nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let addressLabel = UILabel()
            addressLabel.text = kickboard.address
            addressLabel.font = UIFont.systemFont(ofSize: 12)
            addressLabel.textColor = .darkGray
            addressLabel.translatesAutoresizingMaskIntoConstraints = false

            // Gesture 설정
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(kickboardTapped(_:)))
            container.addGestureRecognizer(tapGesture)
            container.isUserInteractionEnabled = true

            container.addSubview(imageView)
            container.addSubview(nicknameLabel)
            container.addSubview(addressLabel)
            containerView.addSubview(container)

            NSLayoutConstraint.activate([
                // 컨테이너 뷰
                container.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 10),
                container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                container.heightAnchor.constraint(equalToConstant: 100),

                // 이미지 뷰
                imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),

                // 닉네임 라벨
                nicknameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
                nicknameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
                nicknameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),

                // 주소 라벨
                addressLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 5),
                addressLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
                addressLabel.trailingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor)
            ])

            previousView = container
            kickboardViews.append(container)
        }
        
        // 마지막 컨테이너 하단 여백 추가
        previousView?.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }

    // MARK: - Gesture Action
    @objc private func kickboardTapped(_ gesture: UITapGestureRecognizer) {
        guard let containerView = gesture.view else { return }
        let index = containerView.tag
        let selectedKickboard = kickboards[index]
        onTap?(selectedKickboard)
    }
}
