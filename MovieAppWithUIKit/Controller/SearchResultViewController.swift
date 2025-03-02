//
//  SearchResultViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 2.03.2025.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var movies : [Movie] = []
    
    
    var searchResultCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var itemSize = CGSize(width: 100, height: 200)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    

}

extension SearchResultViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
        else {return UICollectionViewCell()}
        cell.configure(with: movies[indexPath.row].poster_path ?? "")
        return cell
    }
}
