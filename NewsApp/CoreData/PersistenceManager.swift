//
//  PersistanceManager.swift
//  NewsApp
//
//  Created by Sabina Huseynova on 28.09.21.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: - Core Data stack
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storedDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var context = persistenceContainer.viewContext // MARK: - define
    
    // MARK: - Core Data Saving Support
    
    func save() {
        let context = persistenceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        do {
           try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
}
