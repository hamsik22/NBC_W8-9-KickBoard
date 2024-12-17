//
//  KickboardHistoryView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardHistoryView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 이용 내역"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.backgroundColor = UIColor.systemPurple
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
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
        addSubview(titleLabel)
        addSubview(historyStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            historyStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            historyStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            historyStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            historyStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Method
    func configure(with histories: [KickboardHistory], imageSize: CGSize) {
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for history in histories {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 10
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 1
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(named: history.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let infoLabel = UILabel()
            infoLabel.text = "날짜 \(history.date)\n시간 \(history.time)"
            infoLabel.font = UIFont.systemFont(ofSize: 14)
            infoLabel.textColor = .black
            infoLabel.numberOfLines = 2
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(imageView)
            containerView.addSubview(infoLabel)
            
            NSLayoutConstraint.activate([
                imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
                
                infoLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
            ])
            
            containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            historyStackView.addArrangedSubview(containerView)
        }
    }
}
