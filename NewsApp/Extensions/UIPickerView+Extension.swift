//
//  UIPickerView+Extension.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit

@IBDesignable extension UIPickerView {
    
    func setup() {
//        self.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//        self.separatorColor = .textBlue
//        self.rowHeight = UITableView.automaticDimension
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = .textBlue
        self.backgroundColor = .backGrey

//            self.backgroundColor = .textBlue
//        self.tableFooterView = UIView()
//        self.isHidden = true
        self.layer.cornerRadius = 5
        
      }
}
