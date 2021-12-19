//
//  User+CoreDataProperties.swift
//  CoreDataExample2
//
//  Created by ruslan on 18.12.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var book: Book?

}

extension User : Identifiable {

}
