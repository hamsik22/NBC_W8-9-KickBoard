//
//  MyKickboardDetailViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit
import CoreData

final class MyKickboardDetailViewController: UIViewController, ModalViewDelegate {
    
    private let coreDataManager = CoreDataManager.shared
    
    private let kickboardDetailView = MyKickboardDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewConfiguration()
        setupDetailView()
        kickboardDetailView.delegate = self
    }
    
    private func setupViewConfiguration() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        
        let naviTitle = UILabel()
        naviTitle.text = "내 킥보드 관리"
        naviTitle.textColor = .black
        naviTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.navigationItem.titleView = naviTitle
        self.navigationController?.navigationBar.tintColor = .PersonalNomal.nomal
    }
    
    private func setupDetailView() {
        self.kickboardDetailView.modalViewDelegate = self
        view.addSubview(self.kickboardDetailView)
        
        self.kickboardDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func editKickboardModalView(_ isSaddled: Bool, _ nickName: String, _ id: NSManagedObjectID) {
        let modalVC = RegistrationModalViewController()
        modalVC.editKickboardData(isSaddled, nickName, id)
        
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        modalVC.disappear = { [weak self] in
            guard let self else { return }
            
            self.kickboardDetailView.reloadCellData()
            
        }
        
        self.present(modalVC, animated: true)
    }
    
}

extension MyKickboardDetailViewController: MyKickboardDetailViewDelegate {
    func getKickboardsCount() -> Int {
        coreDataManager.fetchMyKickboards().count
    }
    
    func getKickboards() -> [Kickboard] {
        coreDataManager.fetchMyKickboards()
    }
}
