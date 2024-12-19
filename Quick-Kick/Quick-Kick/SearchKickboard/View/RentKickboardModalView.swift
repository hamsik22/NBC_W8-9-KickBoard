//
//  RentKickboardModalView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/18/24.
//
import UIKit

final class RentKickboardModalView: UIView {
    private var kickboard: Kickboard?
    
    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "QuickBoard")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let kickboardNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let kickboardLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let rentButton: UIButton = {
        let button = UIButton()
        button.setTitle("이용 시작", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "personalNomal/nomal")
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var kickboardVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kickboardNicknameLabel, kickboardLocationLabel, rentButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var kickboardHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kickboardImageView, kickboardVerticalStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    init(kickboard: Kickboard) {
        super.init(frame: .zero)
        self.kickboard = kickboard
        setupModalView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupModalView() {
        self.backgroundColor = .white
        self.kickboardNicknameLabel.text = self.kickboard?.nickName
        self.kickboardLocationLabel.text = self.kickboard?.address
        self.rentButton.addTarget(self, action: #selector(rentButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        self.addSubview(kickboardHorizontalStackView)
        kickboardHorizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(25)
        }
        
        self.layer.cornerRadius = 40
        self.snp.makeConstraints {
            $0.height.equalTo(180)
        }
    }
    
    @objc
    private func rentButtonTapped() {
        if self.kickboard?.startTime == nil {
            self.kickboard?.startTime = Date()
            self.rentButton.titleLabel?.text = "이용 종료"
        } else {
            self.kickboard?.endTime = Date()
            self.rentButton.titleLabel?.text = "이용 시작"
        }
    }
}
