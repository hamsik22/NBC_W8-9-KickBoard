//
//  NoticeView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit

class NoticeView: UIView {
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "지도를 움직여 위치를 선택하세요"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "서울 서초구 강남대로 110 메리츠타워"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [labelStackView]
            .forEach { addSubview($0) }
        
        [noticeLabel, addressLabel]
            .forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
        labelStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension NoticeView: AddressLabelDelegate {
    func bind(_ address: String) {
        addressLabel.text = address
    }
}
