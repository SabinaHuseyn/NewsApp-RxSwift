//
//  ViewController+TableViewDelegate.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func check(_ cell: MainTableViewCell, _ title: String?) {
        if cell.checkCoreDataForExistingWish(title!) {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
        } else {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countrySearched == true {
            return articlesCountryViewModels.count
        }else if categorySearched == true {
            return articlesCategoryViewModels.count
        }else if sourcesSearched == true {
            return articlesSourcesViewModels.count
        }else if searchbarSearched == true {
            return articlesSearchViewModels.count
        }else if publishedDateSearched == true {
            return articlesDateViewModels.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        cell.wishDelegate = self
        
        if countrySearched == true {
            cell.articlesFilterViewModel = articlesCountryViewModels[indexPath.row]
            if let img = articlesCountryViewModels[indexPath.row].urlToImage {
                if let cellUrl = URL(string: img) {
                    cell.articleImg.af.setImage(withURL: cellUrl)
                }
            }
            
            let newsTitle = articlesCountryViewModels[indexPath.row].title
           check(cell, newsTitle!)
            
        }else if categorySearched == true {
            cell.articlesFilterViewModel = articlesCategoryViewModels[indexPath.row]
//                cell.title = artTitle
            if let img = articlesCategoryViewModels[indexPath.row].urlToImage {
                if let cellUrl = URL(string: img) {
                    cell.articleImg.af.setImage(withURL: cellUrl)
                }
            }
            let newsTitle = articlesCategoryViewModels[indexPath.row].title
            check(cell, newsTitle!)
            
        }else if sourcesSearched == true {
            cell.articlesFilterViewModel = articlesSourcesViewModels[indexPath.row]
//                cell.title = artTitle
            if let img = articlesSourcesViewModels[indexPath.row].urlToImage {
                if let cellUrl = URL(string: img) {
                    cell.articleImg.af.setImage(withURL: cellUrl)
                }
            }
            let newsTitle = articlesSourcesViewModels[indexPath.row].title
            check(cell, newsTitle!)

        }else if searchbarSearched == true {
            cell.articlesFilterViewModel = articlesSearchViewModels[indexPath.row]
//                cell.title = artTitle
            if let img = articlesSearchViewModels[indexPath.row].urlToImage {
                if let cellUrl = URL(string: img) {
                    cell.articleImg.af.setImage(withURL: cellUrl)
                }
            }
            let newsTitle = articlesSearchViewModels[indexPath.row].title
            check(cell, newsTitle!)
            
        }else if publishedDateSearched == true {
            cell.articlesFilterViewModel = articlesDateViewModels[indexPath.row]
//                cell.title = artTitle
            if let img = articlesDateViewModels[indexPath.row].urlToImage {
                if let cellUrl = URL(string: img) {
                    cell.articleImg.af.setImage(withURL: cellUrl)
                }
            }
            let newsTitle = articlesDateViewModels[indexPath.row].title
            check(cell, newsTitle!)
            
        }
            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if countrySearched == true {
            if let countryUrl = articlesCountryViewModels[indexPath.row].url {
                mainCoordinator?.detailShow(countryUrl)
            }
        }else if categorySearched == true {
            if let categoryUrl = articlesCategoryViewModels[indexPath.row].url {
            mainCoordinator?.detailShow(categoryUrl)
            }
        }else if sourcesSearched == true {
            if let sourceUrl = articlesSourcesViewModels[indexPath.row].url {
            mainCoordinator?.detailShow(sourceUrl)
            }
        }else if searchbarSearched == true {
            if let searchUrl = articlesSearchViewModels[indexPath.row].url {
            mainCoordinator?.detailShow(searchUrl)
            }
        }else if publishedDateSearched == true {
            if let dateUrl = articlesDateViewModels[indexPath.row].url {
            mainCoordinator?.detailShow(dateUrl)
            }
        }
    }
}
