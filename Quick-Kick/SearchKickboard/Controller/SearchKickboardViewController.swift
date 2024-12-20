//
//  SearchKickboardViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchKickboardViewController: UIViewController {
    let searchKickboardView = SearchKickboardView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchKickboards()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func loadView() {
        super.loadView()
        searchKickboardView.searchKickboardMapView.rentKickboardModalView.alertDelegate = self
        view = searchKickboardView
    }
    
    private func fetchKickboards() {
        let kickboards = CoreDataManager.shared.fetch()
        searchKickboardView.deliverKickboardsData(kickboards)
    }
}

extension SearchKickboardViewController: RentKickboardModalViewAlertDelegate {
    func showAlert(title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        let success = UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "취소", style: .default)

        alert.addAction(success)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}
