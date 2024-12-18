//
//  MyKickboardDetailViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit

final class MyKickboardDetailViewController: UIViewController, ModalViewDelegate {
    
    private let kickboardDetailView = MyKickboardDetailView()
    
    override func loadView() {
        view = self.kickboardDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let naviTitle = UILabel()
        naviTitle.text = "내 킥보드 관리"
        naviTitle.textColor = .black
        naviTitle.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.navigationItem.titleView = naviTitle
        self.kickboardDetailView.modalViewDelegate = self
    }
    
}
