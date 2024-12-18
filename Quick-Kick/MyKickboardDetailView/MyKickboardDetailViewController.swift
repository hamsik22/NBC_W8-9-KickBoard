//
//  MyKickboardDetailViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit

final class MyKickboardDetailViewController: UIViewController, ModalViewDelegate {
    
    private let kickboardDetailView = MyKickboardDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewConfiguration()
        setupDetailView()
    }
    
    private func setupViewConfiguration() {
        view.backgroundColor = .white
        
        let naviTitle = UILabel()
        naviTitle.text = "내 킥보드 관리"
        naviTitle.textColor = .black
        naviTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.navigationItem.titleView = naviTitle
    }
    
    private func setupDetailView() {
        self.kickboardDetailView.modalViewDelegate = self
        view.addSubview(self.kickboardDetailView)
        
        self.kickboardDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
