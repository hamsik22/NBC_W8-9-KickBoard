//
//  RentKickboardModalView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/18/24.
//
import UIKit

final class RentKickboardModalView: UIView {
    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "QuickBoard")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let kickboardNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sparta의 킥보드"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let kickboardLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "서울 중구 세종대로 110 서울특별시청"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(kickboardHorizontalStackView)
    }
    
    private func setupAutoLayout() {
        kickboardHorizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    RentKickboardModalView()
}
