//
//  NewsFilterViewModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 25.09.21.
//

import Foundation
import UIKit

struct NewsFilterViewModel {

let country: String
let id, name, description, category, url, language: String

init(newsFilterModel: NewsFilterModel) {
    self.country = newsFilterModel.country!
    self.id = newsFilterModel.id!
    self.name = newsFilterModel.name!
    self.description = newsFilterModel.description!
    self.category = newsFilterModel.category!
    self.url = newsFilterModel.url!
    self.language = newsFilterModel.language!
//    print("VIEW MODEL:\(self.country)")
}
}
