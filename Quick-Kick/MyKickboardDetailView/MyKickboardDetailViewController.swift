//
//  MyKickboardDetailViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit

final class MyKickboardDetailViewController: UIViewController {
    
    private let kickboardDetailView = MyKickboardDetailView()
    
    override func loadView() {
        view = self.kickboardDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "내 킥보드 관리"
    }
    
}
