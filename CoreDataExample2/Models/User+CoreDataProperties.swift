//
//  User+CoreDataProperties.swift
//  CoreDataExample2
//
//  Created by ruslan on 14.12.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var book: Book?

}

extension User : Identifiable {

}
