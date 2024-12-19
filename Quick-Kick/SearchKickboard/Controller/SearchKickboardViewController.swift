//
//  SearchKickboardViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchKickboardViewController: UIViewController {
    let searchKickboardView = SearchKickboardView()
    
    override func loadView() {
        super.loadView()
        
        fetchKickboards()
        view = searchKickboardView
    }
    
    private func fetchKickboards() {
        let kickboards = CoreDataManager.shared.fetch()
        searchKickboardView.deliverKickboardsData(kickboards)
    }
}
