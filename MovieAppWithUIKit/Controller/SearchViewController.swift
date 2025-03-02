//
//  SearchViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
    var discoverMovies: [Movie] = []               // Tüm filmler (orijinal liste)
    var filteredMovies: [Movie] = []                // Filtrelenmiş filmler (arama sonucu gösterilecek)

    private let discoverTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let searchResultViewController = SearchResultViewController()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.searchBar.placeholder = "Search for a Movie or a TV Show..."
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        
        view.backgroundColor = .white
        
        // TableView setup
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        view.addSubview(discoverTableView)
        
        // SearchController setup
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true  // Arka planı karartmasın
        
        fetchDiscoverMovie()
    }
    
    func fetchDiscoverMovie() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.discoverMovies = movies
                    self?.filteredMovies = movies   // İlk açılışta tümünü göster
                    self?.discoverTableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count  // Arama varsa filtrelenmiş, yoksa tümü
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            filteredMovies = discoverMovies
            discoverTableView.reloadData()
            return
        }
        
        if searchText.isEmpty {
            filteredMovies = discoverMovies
        } else {
            
            filteredMovies = discoverMovies.filter { movie in
                var titlem = movie.original_title ?? ""
                return titlem.lowercased().contains(searchText)
            }
        }
        searchResultViewController.movies = filteredMovies
            searchResultViewController.searchResultCollectionView.reloadData()
        discoverTableView.reloadData()
    }
}

// SwiftUI Preview (Aynı kalabilir)
struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview { SearchViewController() }
            .edgesIgnoringSafeArea(.all)
    }
}
