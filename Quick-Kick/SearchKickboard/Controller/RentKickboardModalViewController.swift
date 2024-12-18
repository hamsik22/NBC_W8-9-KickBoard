//
//  RentKickboardModalViewController.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/18/24.
//
import UIKit

final class RentKickboardModalViewController: UIViewController {
    override func loadView() {
        super.loadView()
        view = RentKickboardModalView()
    }
}
