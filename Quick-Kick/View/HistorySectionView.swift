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
        view.backgroundColor = UIColor.PersonalLight.light
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 이용 내역"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
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

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - Configure Method
    func configure(with histories: [(String, String)]) {
        // 기존 뷰 제거
        historyViews.forEach { $0.removeFromSuperview() }
        historyViews.removeAll()

        var previousView: UIView?

        for history in histories {
            let historyView = createHistoryView(date: history.0, time: history.1)
            historyView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(historyView)
            
            NSLayoutConstraint.activate([
                historyView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 10),
                historyView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                historyView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                historyView.heightAnchor.constraint(equalToConstant: 70)
            ])
            
            previousView = historyView
            historyViews.append(historyView)
        }
        
        previousView?.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func createHistoryView(date: String, time: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        container.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
        
        let imageView = UIImageView(image: UIImage(named: "QuickBoard"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        dateLabel.text = "날짜 \(date)"
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let timeLabel = UILabel()
        timeLabel.text = "운행 시간 \(time)"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(imageView)
        container.addSubview(dateLabel)
        container.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor)
        ])
        
        return container
    }
}
