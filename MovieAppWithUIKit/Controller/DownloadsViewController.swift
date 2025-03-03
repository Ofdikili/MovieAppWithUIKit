//
//  DownloadsViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import UIKit
import SwiftUI

class DownloadsViewController: UIViewController {
    
    var downloads : [MovieItem] = []
    
    private let downloadTable : UITableView = {
       var table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(downloadTable)
        downloadTable.dataSource = self
        downloadTable.delegate = self
        getDownloads()
    }
    
    func getDownloads() {
        DataPercistenceManager.shared.getAllDownloadedMovies { [weak self] results in
            switch results {
            case .failure(let error):
                print("error")
            case .success(let movies):
                self?.downloads = movies
                DispatchQueue.main.async {
                    self?.downloadTable.reloadData()
                }
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
}

extension DownloadsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = downloads[indexPath.row].original_title
        return cell
    }
}

struct DownloadsViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let downloadVc = DownloadsViewController()
            return UINavigationController(rootViewController: downloadVc)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

