//
//  KickboardSectionView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardSectionView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "personalLight/hover") // 색상 적용
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 등록한 킥보드"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
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

        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
        ])
    }

    // MARK: - Configure Method
    func configure(with kickboards: [Kickboard], imageSize: CGSize, onTap: @escaping (Kickboard) -> Void) {
        self.onTap = onTap
        self.kickboards = kickboards

        kickboardViews.forEach { $0.removeFromSuperview() }
        kickboardViews.removeAll()

        var previousView: UIView?

        for (index, kickboard) in kickboards.enumerated() {
            let container = UIView()
            container.backgroundColor = .white
            container.layer.cornerRadius = 20
            container.translatesAutoresizingMaskIntoConstraints = false
            container.tag = index
            
            let imageView = UIImageView(image: UIImage(named: kickboard.isSaddled ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let nicknameLabel = UILabel()
            nicknameLabel.text = kickboard.nickName
            nicknameLabel.font = UIFont.systemFont(ofSize: 14)
            nicknameLabel.textColor = .darkGray
            nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(kickboardTapped(_:)))
            container.addGestureRecognizer(tapGesture)
            container.isUserInteractionEnabled = true
            
            container.addSubview(imageView)
            container.addSubview(nicknameLabel)
            containerView.addSubview(container)

            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 10),
                container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                container.heightAnchor.constraint(equalToConstant: 80),

                imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),

                nicknameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                nicknameLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])

            previousView = container
            kickboardViews.append(container)
        }
    }

    @objc private func kickboardTapped(_ gesture: UITapGestureRecognizer) {
        guard let containerView = gesture.view else { return }
        let index = containerView.tag
        let selectedKickboard = kickboards[index]
        onTap?(selectedKickboard)
    }
}
