//
//  KickboardDataManageable.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import CoreData

// MARK: - KickboardDataManageable Protocol
protocol KickboardDataManageable {
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
