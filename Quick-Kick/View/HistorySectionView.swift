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
        view.layer.cornerRadius = 20
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
    private var histories: [Kickboard] = []

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
    func configure(with histories: [Kickboard]) {
        // 기존 뷰 제거
        historyViews.forEach { $0.removeFromSuperview() }
        historyViews.removeAll()

        self.histories = histories
        var previousView: UIView?

        for kickboard in histories {
            let historyView = createHistoryView(for: kickboard)
            historyView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(historyView)
            
            NSLayoutConstraint.activate([
                historyView.topAnchor.constraint(equalTo: previousView?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 10),
                historyView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                historyView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                historyView.heightAnchor.constraint(equalToConstant: 60)
            ])
            
            previousView = historyView
            historyViews.append(historyView)
        }
        
        previousView?.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Create Individual History View
    private func createHistoryView(for kickboard: Kickboard) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
        
        let dateLabel = UILabel()
        dateLabel.text = formatDate(kickboard.startTime)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 14)
        dateLabel.textColor = .systemPurple
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let timeLabel = UILabel()
        timeLabel.text = "\(formatTime(kickboard.startTime)) - \(formatTime(kickboard.endTime))"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(dateLabel)
        container.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor)
        ])
        
        return container
    }
    
    // MARK: - Helpers
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "날짜 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    private func formatTime(_ date: Date?) -> String {
        guard let date = date else { return "시간 없음" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
