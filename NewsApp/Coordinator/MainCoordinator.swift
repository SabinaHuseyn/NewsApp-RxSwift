//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    init(navigationController: UINavigationController) {
          self.navigationController = navigationController
      }

    func start() {
        let vc = ViewController()
        vc.mainCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func detailShow(_ url: String) {
        let vc = WebViewController()
        vc.webCoordinator = self
        vc.detailsUrl = url
        navigationController.pushViewController(vc, animated: true)
    }
    
    func wishClick() {
        let child = WishListCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
}
