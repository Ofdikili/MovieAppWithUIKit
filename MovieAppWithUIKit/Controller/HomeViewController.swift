//
//  HomeViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

enum HomeSection : Int{
    case trending = 0
    case popular = 1
    case topRated = 4
    case upcoming = 3
    case tv = 2
}

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    var trendingMoviewList : [Movie] = []
    var popularMoviewList : [Movie] = []
    var topRatedMoviewList : [Movie] = []
    var upComingMoviewList : [Movie] = []
    var tvMovieList : [Movie] = []
    let sectionTitle : [String] = ["Trending Movies","Popular","Trending TV","Upcoming Mo","Top rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavBar()
        getTrendingMovies()
        getPopularMovies()
        getTopRatedMovies()
        getUpComingMovies()
        getTvMovies()
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.trendingMoviewList = movies
                    self?.homeFeedTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    private func getPopularMovies() {
        APICaller.shared.getPopular { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.popularMoviewList = movies
                    self?.homeFeedTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    private func getTopRatedMovies() {
        APICaller.shared.getTopRated { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.topRatedMoviewList = movies
                    self?.homeFeedTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    private func getUpComingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.upComingMoviewList = movies
                    self?.homeFeedTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    private func getTvMovies() {
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.tvMovieList = movies
                    self?.homeFeedTable.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    
    func configureNavBar() {
     var image = UIImage(named: "netflixLogo")
        image =    image?.withRenderingMode(.alwaysOriginal)
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image:UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image:UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
       
    }
}

extension HomeViewController : CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MoviePreviewViewModel) {
       DispatchQueue.main.async { [weak self] in
           let vc = MoviePreviewViewController()
           vc.configure(with: viewModel)
           self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case HomeSection.trending.rawValue:
            cell.configure(with: self.trendingMoviewList)
        case HomeSection.popular.rawValue:
            cell.configure(with: self.popularMoviewList)
        case HomeSection.topRated.rawValue:
            cell.configure(with: self.topRatedMoviewList)
        case HomeSection.upcoming.rawValue:
            cell.configure(with: self.upComingMoviewList)
        case HomeSection.tv.rawValue:
            cell.configure(with: self.tvMovieList)
        
        default:
           return UITableViewCell()
        }
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let homeVC = HomeViewController()
            return UINavigationController(rootViewController: homeVC)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
