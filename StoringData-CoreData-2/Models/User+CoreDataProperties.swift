//
//  User+CoreDataProperties.swift
//  StoringData-CoreData-2
//
//  Created by Ruslan on 15.06.2022.
//
//

import UIKit
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: UIImage?
    @NSManaged public var firstName: String?
    @NSManaged public var book: Book?

}

extension User : Identifiable {

}
