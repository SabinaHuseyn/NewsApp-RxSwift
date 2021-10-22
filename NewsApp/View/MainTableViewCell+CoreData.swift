//
//  MainTableViewCell+CoreData.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import CoreData

extension MainTableViewCell {
    
    func checkCoreDataForExistingWish( _ title: String) -> Bool {
               let savedWish = persistenceManager.fetch(WishList.self)
                   for saved in savedWish {
                       if saved.title == title {
                           return true
                       }
                   }
                   return false
               }
           
    func saveWishToFavorites() {
               guard let title = self.title else { return }
               if checkCoreDataForExistingWish(title) {
                   deleteWishFromCoreData()
                   return
               }
        saveWishToCoreData(self.articlesFilterViewModel)
               
           }
           
    func saveWishToCoreData(_ list: ArticlesFilterViewModel) {
        let context = persistenceManager.context
        let newWish = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)
            
            newWish.setValue(list.title, forKey: "title")
            newWish.setValue(list.author, forKey: "author")
            newWish.setValue(list.name, forKey: "name")
            newWish.setValue(list.description, forKey: "descriptionA")
            newWish.setValue(list.urlToImage, forKey: "urlToImage")
            newWish.setValue(list.url, forKey: "url")
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
       
    likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
 }
           
    func deleteWishFromCoreData() {
               let savedWish = persistenceManager.fetch(WishList.self)
               let title = self.title
               
               for currentWish in savedWish {
                   
                   if currentWish.title == title {
                       persistenceManager.delete(currentWish)
                       wishSaved = false
                    likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)
                       break
                   }
               }
           }
    }

