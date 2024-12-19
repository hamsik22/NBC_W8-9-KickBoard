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
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
    }()
    
    private let contentView: UIView = {
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
        addSubview(titleLabel)
        addSubview(contentView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Configure Method
    func configure(with histories: [Kickboard], imageSize: CGSize) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        var previousView: UIView?

        for history in histories {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
            containerView.translatesAutoresizingMaskIntoConstraints = false

            let imageView = UIImageView(image: UIImage(named: history.isSaddled ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            let infoLabel = UILabel()
            infoLabel.text = "\(history.nickName ?? "Unknown") - \(formattedDate(history.startTime))"
            infoLabel.font = UIFont.systemFont(ofSize: 14)
            infoLabel.textColor = .black
            infoLabel.numberOfLines = 2
            infoLabel.translatesAutoresizingMaskIntoConstraints = false

            containerView.addSubview(imageView)
            containerView.addSubview(infoLabel)
            contentView.addSubview(containerView)

            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? contentView.topAnchor, constant: 10),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                containerView.heightAnchor.constraint(equalToConstant: 80),

                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),

                infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                infoLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])

            previousView = containerView
        }
        previousView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "시간 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: date)
    }
}
