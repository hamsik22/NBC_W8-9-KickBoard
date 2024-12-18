//
//  SearchKickboardViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchKickboardViewController: UIViewController {
    private let kickboards: [Kickboard] = CoreDataManager.shared.fetchKickboards()
    
    override func loadView() {
        super.loadView()
        view = SearchKickboardView()
    }
}
