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
    private let typeLabel = UILabel()
    private let addressLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, typeLabel, addressLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureData() {
        titleLabel.text = kickboard.name
        typeLabel.text = "타입: \(kickboard.isSeat ? "안장형" : "일반형")"
        addressLabel.text = "주소: \(kickboard.address)"
    }
}
