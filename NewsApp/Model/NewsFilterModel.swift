//
//  NewsModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 24.09.21.
//

import Foundation

struct NewsFilterModel: Decodable {
    var id, name, description, category, url, language, country: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case category = "category"
        case url = "url"
        case language = "language"
        case country = "country"
    }
}

struct Response: Decodable {
    var status: String
    var sources: [NewsFilterModel]
    
}
