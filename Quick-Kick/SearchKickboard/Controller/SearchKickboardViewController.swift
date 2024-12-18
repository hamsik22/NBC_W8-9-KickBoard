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
        view = searchKickboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchKickboardView.delegate = self
        makeMockData()
    }
}

extension SearchKickboardViewController: SearchKickboardViewDelegate {
    func getKickboardsData() -> [Kickboard] {
        return CoreDataManager.shared.fetchKickboards()
    }
    
    private func makeMockData() {
        CoreDataManager.shared.createKickboard(
            nickName: "씽씽이A",
            isSaddled: false,
            isOccupied: false,
            startTime: nil,
            endTime: nil,
            latitude: 37.498095,
            longitude: 127.027610,
            address: "강남역 1번출구"
        )
        CoreDataManager.shared.createKickboard(
            nickName: "씽씽이B",
            isSaddled: true,
            isOccupied: true,
            startTime: Date(),
            endTime: Date().addingTimeInterval(3600),
            latitude: 37.497922,
            longitude: 127.027637,
            address: "강남역 2번출구"
        )
        CoreDataManager.shared.createKickboard(
            nickName: "씽씽이C",
            isSaddled: false,
            isOccupied: false,
            startTime: nil,
            endTime: nil,
            latitude: 37.504507,
            longitude: 127.048962,
            address: "삼성중앙역 4번출구"
        )
    }
}
