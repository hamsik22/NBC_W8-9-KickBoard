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
        
        label.text = "서울 강남구 강남대로 지하 396 강남역"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    // address 값 전달용 계산 프로퍼티
    var address: String {
        addressLabel.text ?? ""
    }
    
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
            $0.leading.trailing.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
}

extension NoticeView: AddressLabelDelegate {
    func bind(_ address: String) {
        addressLabel.text = address
    }
}
