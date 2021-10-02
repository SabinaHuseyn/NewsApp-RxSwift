//
//  WishViewController+CoreData.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 29.09.21.
//

import Foundation

extension WishListViewController {

    func checkCoreDataForExistingWish( _ wtitle: String) -> Bool {
        let wishes = persistenceManager.fetch(WishList.self)
            for saved in wishes {
                if saved.title == wtitle {
                    return true
                }
            }
            return false
        }
    
    func saveWishToFavorites() {
        guard let wishTitle = self.newsTitle else { return }
        if checkCoreDataForExistingWish(wishTitle) {
            deleteWishFromCoreData()
            wishTableView.reloadData()
            return
        }
//        saveWishToCoreData(wishTitle)
    }
    
//    func saveWishToCoreData(_ wtitle: String) {
//        let newWish = WishList(context: persistenceManager.context)
//        newWish.title = wtitle
//
//        persistenceManager.save()
//        self.wishAlreadySaved = true
//
//        let cell = wishTableView.cellForRow(at: [0,1]) as! MainTableViewCell
//        cell.likeBtn.setImage(#imageLiteral(resourceName: "filledFav"), for: .normal)
//    }
    
    
    func deleteWishFromCoreData() {
        let wish = persistenceManager.fetch(WishList.self)
        let wishTitle = self.newsTitle
        
        for currentWish in wish {
            
            if currentWish.title == wishTitle {
                persistenceManager.delete(currentWish)
                wishAlreadySaved = false
                
                let cell = wishTableView.cellForRow(at: [0,1]) as! MainTableViewCell
                cell.likeBtn.setImage(#imageLiteral(resourceName: "emptyFav"), for: .normal)

                break
            }
        }
    }
    
}

