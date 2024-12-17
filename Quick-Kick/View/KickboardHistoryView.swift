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
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Configure Method
    
    func configure(with histories: [KickboardHistory], imageSize: CGSize) {
        contentView.subviews.forEach { $0.removeFromSuperview() } // 기존 뷰 초기화
        
        var previousView: UIView? = nil
        
        for history in histories {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 1
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(named: history.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let infoLabel = UILabel()
            let boldText = "운행 시간: \(history.date) \(history.time)"
            let attributedString = NSMutableAttributedString(string: boldText)
            attributedString.addAttributes([.font: UIFont.boldSystemFont(ofSize: 14)],
                                           range: NSRange(location: 0, length: 5)) // "운행 시간" 볼드
            infoLabel.attributedText = attributedString
            infoLabel.font = UIFont.systemFont(ofSize: 14)
            infoLabel.textColor = .black
            infoLabel.numberOfLines = 2
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // 뷰 추가
            containerView.addSubview(imageView)
            containerView.addSubview(infoLabel)
            contentView.addSubview(containerView)
            
            // 제약 조건
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
                
                infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                infoLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                
                containerView.heightAnchor.constraint(equalToConstant: 70),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            
            // 이전 뷰와의 상하 간격 설정
            if let previous = previousView {
                containerView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            }
            
            previousView = containerView
        }
        
        // 마지막 뷰의 하단 제약 조건
        previousView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
