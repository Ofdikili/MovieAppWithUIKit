//
//  MoviePreviewViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 2.03.2025.
//

import UIKit
import WebKit



class MoviePreviewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(youtubeWebView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        setUpConstraints()
    }
    
    var titleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var overviewLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton : UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let youtubeWebView : WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private func setUpConstraints() {
        let webViewConstraints: [NSLayoutConstraint] = [
            youtubeWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            youtubeWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            youtubeWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            youtubeWebView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: youtubeWebView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overViewConstraints: [NSLayoutConstraint] = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let downloadButtonConstraints: [NSLayoutConstraint] = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        NSLayoutConstraint.activate(
            webViewConstraints +
            titleConstraints +
            overViewConstraints +
            downloadButtonConstraints
        )
    }
    
    func configure (with model : MoviePreviewViewModel){
        titleLabel.text = model.title
        overviewLabel.text = model.title
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        youtubeWebView.load(URLRequest(url: url))
        
    }
}
