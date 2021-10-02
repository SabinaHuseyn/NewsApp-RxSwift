//
//  Coordinator.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
