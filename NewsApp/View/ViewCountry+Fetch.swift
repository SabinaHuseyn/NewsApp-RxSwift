//
//  ViewCountry+Fetch.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 27.09.21.
//

import Foundation
import UIKit

extension ViewController {
    
//     func fetchData() {
//        Service.shared.fetchNews { (news, err) in
//            if let err = err {
//                print("Failed to fetch news:", err)
//                return
//            }
//            self.newsFilterViewModels = news?.map({return NewsFilterViewModel(newsFilterModel: $0)}) ?? []
//            DispatchQueue.main.async {
//                self.filterSource()
//                self.filterCountry()
//                self.filterCategory()
////                self.mainTableView.reloadData()
//                self.countryTableView.reloadData()
//                self.categoryTableView.reloadData()
//                self.sourceTableView.reloadData()
//            }
//        }
//    }
    
     func fetchCountry(country: String) {
         countrySearched = true
         categorySearched = false
         sourcesSearched = false
         searchbarSearched = false
         publishedDateSearched = false
        Service.shared.fetchNewsCountry(query: country) { news in
//            if self.articlesCountryViewModels.count > 0 {
//                    self.articlesFilterViewModels.removeAll()
//            } else {
                self.articlesCountryViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
                return DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    self.refreshControl.endRefreshing()
                
            }

        }
    }
    
    func fetchSource(source: String) {
        countrySearched = false
        categorySearched = false
        sourcesSearched = true
        searchbarSearched = false
        publishedDateSearched = false
       Service.shared.fetchNewsSource(query: source) { news in
//           if self.articlesFilterViewModels.count > 0 {
//                   self.articlesFilterViewModels.removeAll()
//           } else {
               self.articlesSourcesViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
               DispatchQueue.main.async {
                   self.mainTableView.reloadData()
                   self.refreshControl.endRefreshing()
           }
       }
   }
    
    func fetchCategory(category: String) {
        countrySearched = false
        categorySearched = true
        sourcesSearched = false
        searchbarSearched = false
        publishedDateSearched = false
       Service.shared.fetchNewsCategory(query: category) { news in
//           if self.articlesFilterViewModels.count > 0 {
//                   self.articlesFilterViewModels.removeAll()
//             } else {
           self.articlesCategoryViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
           DispatchQueue.main.async {
               self.mainTableView.reloadData()
               self.refreshControl.endRefreshing()
           
       }
   }
}
    
    func fetchDate(publishedAt: String) {
        countrySearched = false
        categorySearched = false
        sourcesSearched = false
        searchbarSearched = false
        publishedDateSearched = true
       Service.shared.fetchNewsDate(query: publishedAt) { news in
//           if self.articlesFilterViewModels.count > 0 {
//       } else {
           self.articlesDateViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
           DispatchQueue.main.async {
               self.mainTableView.reloadData()
               self.refreshControl.endRefreshing()
           }
       }
   }
}

