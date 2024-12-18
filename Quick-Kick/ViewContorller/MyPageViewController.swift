//
//  MyPageViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit
import CoreData

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
    
    // MARK: - Core Data
    private var kickboardData: [Kickboard] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadKickboards()
        configureSections()
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    }
    
    // MARK: - Core Data: Load Kickboards
    private func loadKickboards() {
        do {
            kickboardData = try CoreDataManager.shared.context.fetch(Kickboard.fetchRequest())
        } catch {
            print("킥보드 데이터를 불러오는 데 실패했습니다: \(error)")
        }
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            profileView.heightAnchor.constraint(equalToConstant: 150),
            
            kickboardSectionView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            kickboardSectionView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            kickboardSectionView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            kickboardSectionView.heightAnchor.constraint(equalToConstant: 120),
            
            historySectionView.topAnchor.constraint(equalTo: kickboardSectionView.bottomAnchor, constant: 10),
            historySectionView.leadingAnchor.constraint(equalTo: kickboardSectionView.leadingAnchor),
            historySectionView.trailingAnchor.constraint(equalTo: kickboardSectionView.trailingAnchor),
            historySectionView.heightAnchor.constraint(equalToConstant: 350),
            
            logoutButton.topAnchor.constraint(equalTo: historySectionView.bottomAnchor, constant: 30),
            logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    // MARK: - Configure Sections
    private func configureSections() {
        // 프로필 설정
        if let user = UserDefaultsManager.shared.getUser() {
            profileView.configure(name: user.nickName, email: user.email)
        } else {
            profileView.configure(name: "User1", email: "user1234@gmail.com") // 기본값 설정
        }
        
        profileView.onNameChange = { newName in
            var user = UserDefaultsManager.shared.getUser() ?? User(email: "user1234@gmail.com", password: "")
            user.nickName = newName
            UserDefaultsManager.shared.saveUser(user)
        }
        
        // 내가 등록한 킥보드 섹션
        kickboardSectionView.configure(with: kickboardData, imageSize: CGSize(width: 50, height: 50)) { [weak self] selectedKickboard in
            let detailVC = KickboardDetailViewController(kickboard: selectedKickboard)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }

        // 히스토리 섹션 설정
        let historyList = kickboardData.filter { $0.startTime != nil && $0.endTime != nil }.map { entity in
            "\(formatDate(entity.startTime)) | \(formatTime(entity.startTime)) - \(formatTime(entity.endTime))"
        }
        
        historySectionView.configure(with: historyList, imageSize: CGSize(width: 40, height: 40))
    }
    
    // MARK: - Helpers
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Unknown Date" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
    
    private func formatTime(_ date: Date?) -> String {
        guard let date = date else { return "Unknown Time" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    // MARK: - Logout Action
    @objc private func handleLogout() {
        UserDefaultsManager.shared.isLoggedIn = false
        print("로그아웃 성공")
        // 로그아웃 후 화면 전환 로직 추가
    }
}
