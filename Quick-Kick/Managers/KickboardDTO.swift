//
//  KickboardDTO.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/19/24.
//

import CoreData

struct KickboardDTO: EntityTransformAble {
    let nickName: String
    let isSaddled: Bool
    let isOccupied: Bool
    let startTime: Date?
    let endTime: Date?
    let latitude: Double
    let longitude: Double
    let address: String

    func toEntity(context: NSManagedObjectContext) -> Kickboard {
        let description = NSEntityDescription.entity(forEntityName: String(describing: Kickboard.self), in: context)!
        let entity = Kickboard(entity: description, insertInto: context)
        entity.nickName = nickName
        entity.isSaddled = isSaddled
        entity.isOccupied = isOccupied
        entity.startTime = startTime
        entity.endTime = endTime
        entity.latitude = latitude
        entity.longitude = longitude
        entity.address = address
        return entity
    }
}
