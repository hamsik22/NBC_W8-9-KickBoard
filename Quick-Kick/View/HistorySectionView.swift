//
//  HistorySectionView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class HistorySectionView: UIView {
    
    // MARK: - UI Components
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 이용 내역"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let historyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
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
        addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        addSubview(historyStackView)
        
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Title Container
            titleContainerView.topAnchor.constraint(equalTo: topAnchor),
            titleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            
            // History Stack View
            historyStackView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 10),
            historyStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            historyStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            historyStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with history: [KickboardHistory], imageSize: CGSize) {
        historyStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in history {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            containerView.layer.shadowOpacity = 0.3
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(named: item.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let infoLabel = UILabel()
            infoLabel.text = "날짜: \(item.date)\n운행 시간: \(item.time)"
            infoLabel.numberOfLines = 2
            infoLabel.font = UIFont.systemFont(ofSize: 14)
            infoLabel.textColor = .darkGray
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            containerView.addSubview(imageView)
            containerView.addSubview(infoLabel)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
                
                infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                infoLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
            ])
            
            containerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            historyStackView.addArrangedSubview(containerView)
        }
    }
}
