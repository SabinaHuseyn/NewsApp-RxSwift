//
//  WishList+CoreDataProperties.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionA: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var url: String?
    @NSManaged public var content: String?
    @NSManaged public var publishedAt: String?

}
