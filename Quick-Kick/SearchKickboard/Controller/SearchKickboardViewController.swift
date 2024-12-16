//
//  SearchKickboardViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchKickboardViewController: UIViewController {
    private let searchKickboardView = SearchKickboardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchKickboardView
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    SearchKickboardViewController()
//}
