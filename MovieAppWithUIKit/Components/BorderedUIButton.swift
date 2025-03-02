//
//  BorderedUIButton.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 28.02.2025.
//

import UIKit

class BorderedUIButton: UIButton {

    private let buttonTitle: String

    init(title: String) {
        self.buttonTitle = title
        super.init(frame: .zero)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        self.buttonTitle = ""
        super.init(coder: coder)
        setupStyle()
    }

    private func setupStyle() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)

        setTitle(buttonTitle, for: .normal)

        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
