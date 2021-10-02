//
//  UILabel+Extension.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.09.21.
//

import Foundation
import UIKit

@IBDesignable extension UILabel {
    
    func setupLbl() {
        self.textAlignment = .center
        self.textColor = .textBlue
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.numberOfLines = 0
      }
    
    func badgeLbl() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.textColor = .white
        self.font = self.font.withSize(12)
        self.backgroundColor = .malina
    }
}
