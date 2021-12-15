//
//  DataStoreManager.swift
//  CoreDataExample2
//
//  Created by ruslan on 14.12.2021.
//

import Foundation
import CoreData

class DataStoreManager {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataExample2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data custom methods
    
    func addNewUser() {
        
        let user = User(context: context)
        let randomNumer = Int.random(in: 0...100)
        user.name = "User #\(randomNumer)"
        
        let book = Book(context: context)
        book.name = "Some book"
        
        user.book = book
        
        saveContext()
    }
    
    func deleteAllUsers() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        if let users = try? context.fetch(fetchRequest) as? [User], !users.isEmpty {
            for user in users {
                context.delete(user)
                saveContext()
            }
        }
    }
}
