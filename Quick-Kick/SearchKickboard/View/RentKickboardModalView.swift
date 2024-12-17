//
//  RentKickboardModalView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/18/24.
//
import UIKit

final class RentKickboardModalView: UIView {
    private let kickboardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
}
