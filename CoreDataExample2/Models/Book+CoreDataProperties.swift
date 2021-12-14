//
//  Book+CoreDataProperties.swift
//  CoreDataExample2
//
//  Created by ruslan on 14.12.2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var owner: User?

}

extension Book : Identifiable {

}
