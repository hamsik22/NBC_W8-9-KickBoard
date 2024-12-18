//
//  MyPageViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileView = ProfileView()
    private let kickboardSectionView = KickboardSectionView()
    private let historySectionView = HistorySectionView()
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = UIColor.systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    // MARK: - Data
    private let kickboardData = [
        Kickboard(name: "Sparta", isSeat: false, address: "서울 중구 세종대로 110"),
        Kickboard(name: "Quick", isSeat: true, address: "서울 중구 세종대로 110"),
        Kickboard(name: "Kick", isSeat: false, address: "서울 중구 세종대로 110")
    ]
    
    private let historyData = [
        KickboardHistory(date: "24.12.01", time: "15:00 - 15:30", isSeat: false),
        KickboardHistory(date: "24.12.02", time: "14:00 - 14:40", isSeat: true),
        KickboardHistory(date: "24.12.03", time: "15:00 - 15:30", isSeat: false)
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureSections()
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [profileView, kickboardSectionView, historySectionView, logoutButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // ScrollView Constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView Constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // ProfileView Constraints
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileView.heightAnchor.constraint(equalToConstant: 150),
            
            // KickboardSectionView Constraints
            kickboardSectionView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10), // 여백 줄임
            kickboardSectionView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            kickboardSectionView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            kickboardSectionView.heightAnchor.constraint(equalToConstant: 120),
            
            // HistorySectionView Constraints
            historySectionView.topAnchor.constraint(equalTo: kickboardSectionView.bottomAnchor, constant: 10),
            historySectionView.leadingAnchor.constraint(equalTo: kickboardSectionView.leadingAnchor),
            historySectionView.trailingAnchor.constraint(equalTo: kickboardSectionView.trailingAnchor),
            historySectionView.heightAnchor.constraint(equalToConstant: 350),
            
            // LogoutButton Constraints
            logoutButton.topAnchor.constraint(equalTo: historySectionView.bottomAnchor, constant: 30),
            logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    // MARK: - Configure Sections
    private func configureSections() {
        profileView.configure(name: "User ✏️", email: "user1234@gmail.com", imageName: "QuickBoard")
        
        // 내가 등록한 킥보드 섹션 설정
        kickboardSectionView.configure(with: kickboardData, imageSize: CGSize(width: 50, height: 50)) { [weak self] selectedKickboard in
            let detailVC = KickboardDetailViewController(kickboard: selectedKickboard)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        // 킥보드 이용 내역 섹션 설정
        historySectionView.configure(with: historyData, imageSize: CGSize(width: 40, height: 40))
    }
    
    // MARK: - Action Methods
    @objc private func handleLogout() {
        print("로그아웃 버튼이 눌렸습니다.")
        // TODO: 로그아웃 로직 추가 (e.g., UserDefaults 삭제, 로그인 화면 전환 등)
    }
}
