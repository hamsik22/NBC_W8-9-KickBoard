//
//  MyKickboardDetailViewItem.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit

final class MyKickboardDetailViewItem: UICollectionViewCell {
    
    private let kickboardImage = UIImageView()
    private let kickboardNickNameView = UILabel()
    private let kickboardLocationView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
