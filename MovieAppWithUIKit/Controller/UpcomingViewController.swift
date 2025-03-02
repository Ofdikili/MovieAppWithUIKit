//
//  UpcomingViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

class UpcomingViewController: UIViewController {
    
    var upComingMoviewList : [Movie] = []
    
    var tableView : UITableView = {
        var table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = "UpComing"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar
            .topItem?.largeTitleDisplayMode = .always
        tableView.dataSource = self
        tableView.delegate = self
        getUpComingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func getUpComingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.upComingMoviewList = movies
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
        }
    }
    
}

extension UpcomingViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingMoviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = upComingMoviewList[indexPath.row]
        cell.configure(with: movie )
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

struct UpcomingViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let upcomingViewController = UpcomingViewController()
            return UINavigationController(rootViewController: upcomingViewController)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
