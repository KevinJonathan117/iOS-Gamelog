//
//  GameItem+CoreDataProperties.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 09/10/22.
//
//

import Foundation
import CoreData


extension GameItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameItem> {
        return NSFetchRequest<GameItem>(entityName: "GameItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var released: String?
    @NSManaged public var backgroundImage: String?
    @NSManaged public var rating: Double

}

extension GameItem: Identifiable {

}
