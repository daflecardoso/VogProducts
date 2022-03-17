//
//  AppCoordinator.swift
//  VogProducts
//
//  Created by Dafle on 17/03/22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private weak var appDelegate: AppDelegate?
    let window: UIWindow
    
    init(appDelegate: AppDelegate?, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
    }
    
    func start() {
        window.rootViewController = makeProductsViewController()
        window.makeKeyAndVisible()
    }
    
    private func makeProductsViewController() -> ProductsViewController {
        .init(viewModel: .init(productsService: ProductService()))
    }
}
