//
//  HistoryItemView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class HistoryItemView: UIView {
    
    // MARK: - Initialization
    init(history: KickboardHistory, imageSize: CGSize) {
        super.init(frame: .zero)
        
        let imageView = UIImageView(image: UIImage(named: history.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let infoLabel = UILabel()
        infoLabel.text = "\(history.date) | \(history.time)"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        containerView.addSubview(infoLabel)
        
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            // Container constraints
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Image constraints
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            
            // Label constraints
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            infoLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        // Shadow (Optional)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
