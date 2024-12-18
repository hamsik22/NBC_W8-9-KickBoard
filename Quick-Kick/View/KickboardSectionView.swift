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
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 등록한 킥보드"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private var kickboardViews: [UIView] = [] // 킥보드 뷰 리스트

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
            // Container View
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Title Label
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
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
            let imageContainer = UIView()
            imageContainer.backgroundColor = .white
            imageContainer.layer.cornerRadius = imageSize.width / 2
            imageContainer.layer.shadowOpacity = 0.1
            imageContainer.translatesAutoresizingMaskIntoConstraints = false
            imageContainer.tag = index
            
            let imageView = UIImageView(image: UIImage(named: kickboard.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(kickboardTapped(_:)))
            imageContainer.addGestureRecognizer(tapGesture)
            imageContainer.isUserInteractionEnabled = true
            
            imageContainer.addSubview(imageView)
            containerView.addSubview(imageContainer)
            
            NSLayoutConstraint.activate([
                imageContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                imageContainer.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageContainer.heightAnchor.constraint(equalToConstant: imageSize.height),

                imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width * 0.6),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height * 0.6),
                
                imageContainer.leadingAnchor.constraint(equalTo: previousView?.trailingAnchor ?? containerView.leadingAnchor, constant: 15)
            ])

            kickboardViews.append(imageContainer)
            previousView = imageContainer
        }
    }

    @objc private func kickboardTapped(_ gesture: UITapGestureRecognizer) {
        guard let containerView = gesture.view else { return }
        let index = containerView.tag
        let selectedKickboard = kickboards[index]
        onTap?(selectedKickboard)
    }
}
