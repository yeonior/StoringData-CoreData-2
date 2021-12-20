//
//  User+CoreDataProperties.swift
//  CoreDataExample2
//
//  Created by ruslan on 20.12.2021.
//
//

import Foundation
import CoreData
import UIKit

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var avatar: UIImage?
    @NSManaged public var book: Book?

}

extension User : Identifiable {

}
