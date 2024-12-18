//
//  KickboardListViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit
import CoreData

class KickboardListViewController: UIViewController {
    private let kickboards: [Kickboard] // Core Data Kickboard 사용
    
    private let tableView = UITableView()
    
    init(kickboards: [Kickboard]) {
        self.kickboards = kickboards
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "내 킥보드 관리"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension KickboardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kickboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let kickboard: Kickboard = kickboards[indexPath.row] // 명확하게 CoreData.Kickboard 사용
        
        let typeText = kickboard.isSaddled ? "안장형" : "일반형"
        cell.textLabel?.text = "\(kickboard.nickName ?? "이름 없음") - \(typeText)"
        
        return cell
    }
}
