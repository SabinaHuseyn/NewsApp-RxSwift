//
//  UIButton+Extension.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {
    
    func rightImage(image: UIImage) {
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.contentVerticalAlignment = .fill
        self.semanticContentAttribute = .unspecified
        self.contentHorizontalAlignment = .left
        self.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 200.0, bottom: 5.0, right: 5.0)
//        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 100.0)

      }
    
    func setBtn(_ name: String){
        self.layer.cornerRadius = 5
        self.backgroundColor = .backDarkGrey
        self.setTitle(name, for: .normal)
        self.rightImage(image: UIImage(named: "addBtn")!)
        self.setTitleColor(.textBlue, for: .normal)
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
