//
//  SearchKickboardViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchKickboardViewController: UIViewController {
    override func loadView() {
        super.loadView()
        view = SearchKickboardView()
    }
}
