//
//  HistorySectionView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class HistorySectionView: UIView {
    
    // MARK: - UI Components
    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "personalLight/hover") // 색상 적용
            view.layer.cornerRadius = 10
            return view
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "킥보드 이용 내역"
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
            return label
        }()

    private var historyViews: [UIView] = []

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
    func configure(with histories: [KickboardHistory], imageSize: CGSize) {
        historyViews.forEach { $0.removeFromSuperview() }
        historyViews.removeAll()
        
        var previousView: UIView?

        for history in histories {
            let container = UIView()
            container.backgroundColor = .white
            container.layer.cornerRadius = 20
            container.translatesAutoresizingMaskIntoConstraints = false

            let imageView = UIImageView(image: UIImage(named: history.isSeat ? "QuickBoard - Seat" : "QuickBoard"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let infoLabel = UILabel()
            infoLabel.numberOfLines = 2
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // 볼드체 적용
            let boldText = NSMutableAttributedString()
            let dateText = NSAttributedString(string: "날짜 ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            let dateValue = NSAttributedString(string: "\(history.date)\n", attributes: [.font: UIFont.systemFont(ofSize: 14)])
            let timeText = NSAttributedString(string: "운행 시간 ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            let timeValue = NSAttributedString(string: "\(history.time)", attributes: [.font: UIFont.systemFont(ofSize: 14)])

            boldText.append(dateText)
            boldText.append(dateValue)
            boldText.append(timeText)
            boldText.append(timeValue)

            infoLabel.attributedText = boldText

            container.addSubview(imageView)
            container.addSubview(infoLabel)
            containerView.addSubview(container)

            NSLayoutConstraint.activate([
                container.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 10),
                container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                container.heightAnchor.constraint(equalToConstant: 70),

                imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
                
                infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                infoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
                infoLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])

            previousView = container
            historyViews.append(container)
        }
    }
}
