//
//  ViewCountry+Fetch.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 27.09.21.
//

import Foundation
import UIKit

extension ViewController {

     func fetchCountry(country: String) {
         countrySearched = true
         categorySearched = false
         sourcesSearched = false
         searchbarSearched = false
         publishedDateSearched = false
         Service.shared.fetchNewsCountry(query: country) { news in
                return DispatchQueue.main.async {
                    self.articlesCountryViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
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
               DispatchQueue.main.async {
                   self.articlesSourcesViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
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
           DispatchQueue.main.async {
               self.articlesCategoryViewModels = news.map({return ArticlesFilterViewModel(articlesFilterModel: $0)})
               self.mainTableView.reloadData()
               self.refreshControl.endRefreshing()
           
       }
   }
}
    
}

