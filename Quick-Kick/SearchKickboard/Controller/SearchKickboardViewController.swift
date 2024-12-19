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
        makeMockData()
    }
}

extension SearchKickboardViewController {
    private func makeMockData() {
        print(CoreDataManager.shared.fetch())
        let data = KickboardDTO(
            nickName: "씽씽이A",
            isSaddled: false,
            isOccupied: false,
            startTime: nil,
            endTime: nil,
            latitude: 37.517430,
            longitude: 127.047515,
            address: "강남역 1번출구"
        )
        CoreDataManager.shared.create(with: data)
    }
}
