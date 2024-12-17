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
        view.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.2)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 등록한 킥보드"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private var onTap: ((Kickboard) -> Void)?

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
        containerView.addSubview(stackView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Container View Constraints
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            
            // StackView Constraints
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Configure Method
    func configure(with kickboards: [Kickboard], imageSize: CGSize, onTap: @escaping (Kickboard) -> Void) {
        self.onTap = onTap
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for kickboard in kickboards {
            // Create Image Container
            let imageContainer = UIView()
            imageContainer.backgroundColor = .white
            imageContainer.layer.cornerRadius = imageSize.width / 2
            imageContainer.layer.shadowColor = UIColor.black.cgColor
            imageContainer.layer.shadowOpacity = 0.1
            imageContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(named: kickboard.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(kickboardTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            
            // Add Image to Container
            imageContainer.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageContainer.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageContainer.heightAnchor.constraint(equalToConstant: imageSize.height),
                
                imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width * 0.6),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height * 0.6)
            ])
            
            stackView.addArrangedSubview(imageContainer)
        }
    }

    @objc private func kickboardTapped(_ gesture: UITapGestureRecognizer) {
        guard let index = stackView.arrangedSubviews.firstIndex(of: gesture.view?.superview ?? UIView()) else { return }
        let tappedKickboard = Kickboard(name: "Tapped \(index)", isSeat: false, address: "")
        onTap?(tappedKickboard)
    }
}
