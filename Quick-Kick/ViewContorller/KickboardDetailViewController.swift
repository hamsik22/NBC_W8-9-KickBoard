//
//  KickboardDetailViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardDetailViewController: UIViewController {
    
    private let kickboard: Kickboard
    
    init(kickboard: Kickboard) {
        self.kickboard = kickboard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel = UILabel()
    private let saddledLabel = UILabel()
    private let occupiedLabel = UILabel()
    private let addressLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, saddledLabel, occupiedLabel, addressLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 18)
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            saddledLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            saddledLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            occupiedLabel.topAnchor.constraint(equalTo: saddledLabel.bottomAnchor, constant: 20),
            occupiedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: occupiedLabel.bottomAnchor, constant: 20),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureData() {
        titleLabel.text = "닉네임: \(kickboard.nickName ?? "Unnamed")"
        saddledLabel.text = "안장형: \(kickboard.isSaddled ? "Yes" : "No")"
        occupiedLabel.text = "사용 상태: \(kickboard.isOccupied ? "사용 중" : "미사용")"
        addressLabel.text = "주소: \(kickboard.address ?? "주소 없음")"
    }
}
