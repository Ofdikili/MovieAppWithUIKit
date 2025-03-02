//
//  CollectionViewTableViewCell.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

class CollectionViewTableViewCell: UITableViewCell {
    
    private var items: [Movie] = []
    
    static let identifier = "CollectionViewTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200 )
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(with movies: [Movie]) {
           self.items = movies
           collectionView.reloadData()
       }
    
}

extension CollectionViewTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let poster = items[indexPath.item].poster_path else  { return UICollectionViewCell()}
        cell.configure(with : poster)
        return cell
    }
}


struct CollectionViewCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> CollectionViewTableViewCell {
        return CollectionViewTableViewCell()
    }
    
    func updateUIView(_ uiView: CollectionViewTableViewCell, context: Context) {}
}

struct CollectionViewTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCellPreview()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
