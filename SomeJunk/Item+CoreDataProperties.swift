//
//  Item+CoreDataProperties.swift
//  SomeJunk
//
//  Created by Kevin Ok on 4/9/16.
//  Copyright © 2016 Monsieurdaccord. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var title: String?
    @NSManaged var details: String?
    @NSManaged var price: NSNumber?
    @NSManaged var created: NSDate?
    @NSManaged var store: Store?
    @NSManaged var image: Image?
    @NSManaged var itemType: NSManagedObject?

}
