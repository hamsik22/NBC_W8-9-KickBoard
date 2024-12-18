//
//  Kickboard+CoreDataProperties.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import Foundation
import CoreData

@objc(Kickboard)
public class Kickboard: NSManagedObject {}

extension Kickboard {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kickboard> {
        return NSFetchRequest<Kickboard>(entityName: "Kickboard")
    }

    @NSManaged public var nickName: String
    @NSManaged public var isSaddled: Bool
    @NSManaged public var isOccupied: Bool
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var address: String
}

extension Kickboard: Identifiable {}
