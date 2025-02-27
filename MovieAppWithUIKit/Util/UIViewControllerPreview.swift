//
//  UIViewControllerPreview.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

//struct MainTabbarViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabbarViewControllerPreview()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct MainTabbarViewControllerPreview: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> MainTabbarViewController {
//        return MainTabbarViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: MainTabbarViewController, context: Context) {}
//}

import SwiftUI
import UIKit

struct UIViewControllerPreview<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T

    init(_ builder: @escaping () -> T) {
        self.viewController = builder()
    }

    func makeUIViewController(context: Context) -> T {
        return viewController
    }

    func updateUIViewController(_ uiViewController: T, context: Context) {}
}
