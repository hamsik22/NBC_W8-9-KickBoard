//
//  SearchLocationBarView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit

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
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SearchIcon.png"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        return button
    }()
    
    private let searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBar, searchButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.resultTypes = .address
        return completer
    }()
    
    private var searchResults: [MKLocalSearchCompletion] = []
    weak var mapView: MKMapView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(searchStackView)
        searchStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        self.addSubview(searchResultsTableView)
        searchResultsTableView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(200)
        }
    }
    
    private func setupDelegate() {
        searchBar.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchCompleter.delegate = self
    }
}

extension SearchLocationBarView: UISearchBarDelegate {
    
}

extension SearchLocationBarView: MKLocalSearchCompleterDelegate {
    
}

extension SearchLocationBarView: UITableViewDelegate {
    
}

extension SearchLocationBarView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
