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
        searchBar.searchBarStyle = .minimal
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        return searchBar
    }()
    
//    private let searchButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "SearchIcon.png"), for: .normal)
//        button.tintColor = .black
//        button.backgroundColor = .clear
//        return button
//    }()
    
    private let searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
//    private lazy var searchStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [searchBar, searchButton])
//        stackView.axis = .horizontal
//        stackView.distribution = .fill
//        stackView.alignment = .fill
//        stackView.spacing = 10
//        return stackView
//    }()
    
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
        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        self.addSubview(searchResultsTableView)
        searchResultsTableView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(180)
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResults = []
            searchResultsTableView.isHidden = true
            searchResultsTableView.reloadData()
        } else {
            searchResultsTableView.isHidden = false
            searchCompleter.queryFragment = searchText
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultsTableView.isHidden = searchBar.text?.isEmpty ?? true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchResultsTableView.isHidden = true
    }
}

extension SearchLocationBarView: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("주소 검색 오류: \(error.localizedDescription)")
    }
}

extension SearchLocationBarView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택됨: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        print("검색 시작...")
        search.start { [weak self] (response, error) in
            if let error = error {
                print("검색 에러: \(error.localizedDescription)")
                return
            }
            print("검색 응답: \(String(describing: response))")
            
            guard let self = self else {
                print("self가 nil입니다.")
                return
            }
            
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                print("좌표를 구할 수 없습니다.")
                return
            }
            print("좌표 찾음: \(coordinate)")
            
            let region = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            self.mapView?.setRegion(region, animated: true)
            self.searchBar.resignFirstResponder()
        }
    }
}

extension SearchLocationBarView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let searchResult = searchResults[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = searchResult.title
        content.secondaryText = searchResult.subtitle
        cell.contentConfiguration = content
        
        return cell
    }
}
