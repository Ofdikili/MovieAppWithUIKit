//
//  CollectionViewTableViewCell.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(
        _ cell: CollectionViewTableViewCell
        ,viewModel: MoviePreviewViewModel
    )
}

class CollectionViewTableViewCell: UITableViewCell {
    
    private var items: [Movie] = []
    
    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
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
    
    private func downloadTitleAt(indexPath:IndexPath){
        DataPercistenceManager.shared.DownloadMoview(with: items[indexPath.item], completeion: {result in
            switch result {
            case .success():
                print("success")
            case .failure(_):
                print("error")
            }
        }
    )}
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = items[indexPath.row]
        guard let titleName = movie.original_name else { return }
        APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let movie = self?.items[indexPath.row]
                    guard let overview =
                            movie?.overview else {
                        return
                    }
                    guard let strongSelf =
                            self else {
                        return
                    }
                    let viewModel = MoviePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: overview)
                    self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf,viewModel:viewModel)
                    print(videoElement)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func downloadMovie(indexPath:IndexPath){
        print("Downloading movie at \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let shareAction = UIAction(title: "Downlaod", image: UIImage(systemName: "square.and.arrow.up")) { [self] action in
                downloadTitleAt(indexPath: indexPath)
            }

            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                print("Delete tapped for item at \(indexPath)")
            }

            return UIMenu(title: "Movie Actions", children: [shareAction, deleteAction])
        }
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
