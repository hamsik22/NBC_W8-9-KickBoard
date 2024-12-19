//
//  KickboardDataManageable.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import CoreData

// MARK: - KickboardDataManageable Protocol
protocol KickboardDataManageable {
    var context: NSManagedObjectContext { get }
    func createKickboard(nickName: String,
                         isSaddled: Bool,
                         isOccupied: Bool,
                         startTime: Date?,
                         endTime: Date?,
                         latitude: Double,
                         longitude: Double,
                         address: String)
    func fetchKickboards() -> [Kickboard]
    func deleteKickboard(_ kickboard: Kickboard)
    func saveContext()
}

// MARK: - Default Implementations
extension KickboardDataManageable {
    func createKickboard(nickName: String,
                         isSaddled: Bool,
                         isOccupied: Bool = false,
                         startTime: Date? = nil,
                         endTime: Date? = nil,
                         latitude: Double,
                         longitude: Double,
                         address: String) {
        let newKickboard = Kickboard(context: context)
        newKickboard.nickName = nickName
        newKickboard.isSaddled = isSaddled
        newKickboard.isOccupied = isOccupied
        newKickboard.startTime = startTime
        newKickboard.endTime = endTime
        newKickboard.latitude = latitude
        newKickboard.longitude = longitude
        newKickboard.address = address
        saveContext()
    }
    
    func fetchKickboards() -> [Kickboard] {
        let request: NSFetchRequest<Kickboard> = Kickboard.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteKickboard(_ kickboard: Kickboard) {
        context.delete(kickboard)
        saveContext()
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }
}
