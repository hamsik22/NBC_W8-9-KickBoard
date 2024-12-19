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
    private let contentView = UIView()
    
    private let profileView = ProfileView()
    private let kickboardSectionView = KickboardSectionView()
    private let historySectionView = HistorySectionView()
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = UIColor.PersonalNomal.nomal
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
        viewTapAction()
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
        
        view.addSubview(contentView)
        
        [profileView, kickboardSectionView, historySectionView, logoutButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            profileView.heightAnchor.constraint(equalToConstant: 150),
            
            kickboardSectionView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            kickboardSectionView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            kickboardSectionView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            kickboardSectionView.heightAnchor.constraint(equalToConstant: 100),
            
            historySectionView.topAnchor.constraint(equalTo: kickboardSectionView.bottomAnchor, constant: 10),
            historySectionView.leadingAnchor.constraint(equalTo: kickboardSectionView.leadingAnchor),
            historySectionView.trailingAnchor.constraint(equalTo: kickboardSectionView.trailingAnchor),
            historySectionView.heightAnchor.constraint(equalToConstant: 350),
            
            logoutButton.topAnchor.constraint(equalTo: historySectionView.bottomAnchor, constant: 30),
            logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: historySectionView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: historySectionView.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Configure Sections
    private func configureSections() {
        // 프로필 설정
        if let user = UserDefaultsManager.shared.getUser() {
            profileView.configure(name: user.nickName, email: user.email)
        } else {
            profileView.configure(name: "User1", email: "user1234@gmail.com")
        }
        
        profileView.onNameChange = { newName in
            var user = UserDefaultsManager.shared.getUser() ?? User(email: "user1234@gmail.com", password: "")
            user.nickName = newName
            UserDefaultsManager.shared.saveUser(user)
        }
        
        // 내가 등록한 킥보드 섹션
        kickboardSectionView.configure {
            // "내가 등록한 킥보드 >"를 클릭했을 때 상세 화면으로 이동
            let detailVC = MyKickboardDetailViewController()
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        // 히스토리 섹션 설정
        let historyList = kickboardData.filter { $0.startTime != nil && $0.endTime != nil }
        historySectionView.configure(with: historyList)
    }

    
    // MARK: - Logout Action
    // 로그아웃 액션
    @objc private func handleLogout() {
        logoutAlert() { [weak self] in
            guard let self else { return }
            UserDefaultsManager.shared.setLoggedOut()
            print("로그아웃 성공")
            
            DispatchQueue.main.async {
                UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionCrossDissolve) {
                    let loginView = LoginViewController()
                    self.view.window?.rootViewController = UINavigationController(rootViewController: loginView)
                    self.successLogoutAlert(view: loginView)
                }
            }
        }
    }
    
    private func logoutAlert(_ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "경고", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive) { _ in
            completion()
        })
        
        self.present(alert, animated: true)
    }
    
    private func successLogoutAlert(view: UIViewController) {
        let alert = UIAlertController(title: "알림", message: "로그아웃 되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        view.present(alert, animated: true)
    }
    
    private func viewTapAction() {
        let touchEvent = UITapGestureRecognizer(target: self, action: #selector(pushDetailView))
        self.kickboardSectionView.addGestureRecognizer(touchEvent)
    }
    
    @objc private func pushDetailView() {
        self.navigationController?.pushViewController(MyKickboardDetailViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
