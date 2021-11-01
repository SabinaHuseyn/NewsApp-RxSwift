//
//  WishListCoordinator.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit

final class WishListCoordinator: Coordinator{
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func detailShow(_ url: String) {
        let vc = WebViewController()
//        vc.webCoordinator = self
        vc.detailsUrl = url
        navigationController.pushViewController(vc, animated: true)
    }
    
}
