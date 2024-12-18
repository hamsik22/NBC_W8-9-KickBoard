//
//  MyKickboardDetailViewItem.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit

final class MyKickboardDetailViewItem: UICollectionViewCell {
    
    static let id: String = "MyKickboardDetailViewItem"
    
    private let kickboardImage = UIImageView()
    private let kickboardNickNameView = UILabel()
    private let kickboardLocationView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
    }
    
    private func configUI() {
        self.layer.cornerRadius = 30
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
        
        setupImageView()
        setupLabel()
        setupLayout()
        addAction()
    }
    
    private func addAction() {
        self.addGestureRecognizer(.init(target: self, action: #selector(presentModal)))
    }
    
    @objc func presentModal() {
        // 모달 오픈 기능 추가
    }
    
    private func setupImageView() {
        self.kickboardImage.contentMode = .scaleAspectFit
        self.kickboardImage.backgroundColor = .clear
        self.addSubview(self.kickboardImage)
    }
    
    private func setupLabel() {
        [self.kickboardNickNameView,
         self.kickboardLocationView].forEach {
            $0.textColor = .black
            $0.textAlignment = .right
            $0.numberOfLines = 1
            $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            self.addSubview($0)
        }

        setupLocationLabel()
    }
    
    private func setupLocationLabel() {
        self.kickboardLocationView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.kickboardLocationView.numberOfLines = 2
        self.kickboardLocationView.minimumScaleFactor = 0.8
    }
    
    private func setupLayout() {
        self.kickboardImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(100)
        }
        
        self.kickboardNickNameView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(30)
        }
        
        self.kickboardLocationView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.kickboardNickNameView.snp.bottom).offset(5)
            $0.width.equalTo(200)
        }
    }
    
    func insertKickboardImage(type isSaddle: Bool) {
        // 코어데이터에서 안장타입인지 값을 받고 이에 따라 이미지 변경
        switch isSaddle {
        case true:
            self.kickboardImage.image = UIImage(named: "QuickBoard - Seat")
        case false:
            self.kickboardImage.image = UIImage(named: "QuickBoard")
        }
    }
    
    /// 코어데이터에서 현재 사용중인지 여부를 받아서 색 변경
    func useKickboard(_ isOccupied: Bool) {
        switch isOccupied {
        case true:
            self.backgroundColor = .PersonalLight.active
        case false:
            self.backgroundColor = .white
        }
    }
    
    func updateKickboardInfo(nickName: String, location: String) {
        self.kickboardNickNameView.text = nickName
        self.kickboardLocationView.text = location
        self.layoutIfNeeded()
    }
}
