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
        view.backgroundColor = UIColor.PersonalLight.light
        view.layer.cornerRadius = 32
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleButton: UIButton = {
        let button = UIButton()
        button.setTitle("내가 등록한 킥보드 >", for: .normal)
        button.setTitleColor(.black, for: .normal) // 텍스트 색상을 검정색으로 변경
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left // 좌측 정렬
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var onTap: (() -> Void)?

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
        containerView.addSubview(titleButton)

        NSLayoutConstraint.activate([
            // ContainerView Constraints
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8), // 상단 여백 (더 줄임)
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor), // 기본 너비로
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor), // 기본 너비로
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8), // 하단 여백 (더 줄임)
            
            // TitleButton Constraints
            titleButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5), // 제목 버튼 상단 여백
            titleButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10), // 좌측 여백
            titleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10), // 우측 여백
            titleButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5) // 제목 버튼 하단 여백
        ])

        // Add action for button
        titleButton.addTarget(self, action: #selector(didTapTitleButton), for: .touchUpInside)
    }

    // MARK: - Configure
    func configure(onTap: @escaping () -> Void) {
        self.onTap = onTap
    }

    // MARK: - Action
    @objc private func didTapTitleButton() {
        onTap?() // 상세정보 화면으로 이동
    }
}
