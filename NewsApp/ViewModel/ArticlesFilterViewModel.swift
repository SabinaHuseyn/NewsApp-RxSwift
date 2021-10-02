//
//  ArticlesFilterViewModel.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 26.09.21.
//

import Foundation
import UIKit

struct ArticlesFilterViewModel {
    var id: String?
    var name: String?
    var author, title, description, urlToImage, url, publishedAt, content: String?
    
// Dependency Injection (DI)
init(articlesFilterModel: ArticleModel) {
    if let articId = articlesFilterModel.source?.id {
        self.id = articId
    }
    if let articSource = articlesFilterModel.source {
        if let articSourceName = articSource.name {
            self.name = articSourceName
        }
    }
    if let articAuthor = articlesFilterModel.author {
        self.author = articAuthor
    }
    if let articTitle = articlesFilterModel.title {
        self.title = articTitle
    }
    if let articDescription = articlesFilterModel.description {
        self.description = articDescription
    }
    if let articUrlToImage = articlesFilterModel.urlToImage {
        self.urlToImage = articUrlToImage
    }
    if let articUrl = articlesFilterModel.url {
        self.url = articUrl
    }
    if let articPublishedAt = articlesFilterModel.publishedAt {
        self.publishedAt = articPublishedAt
    }
    
    if let articContent = articlesFilterModel.content {
        self.content = articContent
    }
    
}
}
