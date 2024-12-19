//
//  UITextField+Ext.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/18/24.
//

import UIKit

extension UITextField {
    /// UITextField의 UI 세팅을 위한 함수
    func setCustomPlaceholder(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 14)
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor.PersonalLight.light
        tf.setPlaceholder(color: UIColor.PersonalLight.active)
        tf.layer.cornerRadius = 10
        return tf
    }
    /// UITextField 색깔 변경 하는 함수
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
