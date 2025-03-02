//
//  HeroHeaderUIView.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 28.02.2025.
//

import UIKit
class HeroHeaderUIView: UIView {

    private let heroView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heroExampleImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton : UIButton = {
        let button = BorderedUIButton(title: "Play")
        return button
    }()
    
    private let downloadButton : UIButton = {
        let button = BorderedUIButton(title: "Download")
        return button
    }()

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let playButtonConstraints: [NSLayoutConstraint] =  [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor
                                               ,constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
        
        ]
        
        let downloadButtonConstraints: [NSLayoutConstraint] =  [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
        
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        heroView.frame = bounds
    }

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
