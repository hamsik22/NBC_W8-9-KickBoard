//
//  UIViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/19/24.
//

import UIKit

extension UIViewController {
    /// 간단한 경고창을 생성하는 함수
    func showAlert(title: String = "경고", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
