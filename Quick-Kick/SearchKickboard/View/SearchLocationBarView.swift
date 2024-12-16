//
//  SearchLocationBarView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit

final class SearchLocationBarView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "주소 검색"
        searchBar.searchTextField.backgroundColor = .clear
        return searchBar
    }()
}
