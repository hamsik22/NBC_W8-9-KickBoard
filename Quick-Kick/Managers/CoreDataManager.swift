//
//  CoreDataManager.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import CoreData

protocol CoreDataManageable {
    associatedtype Model: EntityTransformAble
    associatedtype Entity: NSManagedObject

    func create(with model: Model)
    func fetch() -> [Entity]
    func delete(_ entity: Entity)
    func saveContext() throws
}

protocol EntityTransformAble {
    associatedtype Entity: NSManagedObject
    func toEntity(context: NSManagedObjectContext) -> Entity
}


final class CoreDataManager: CoreDataManageable {
    typealias Model = KickboardDTO
    typealias Entity = Kickboard

    // MARK: - Singleton
    static let shared = CoreDataManager()
    private init() {}

    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "KickboardModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data Error: \(error.localizedDescription)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - CoreDataManageable Methods
    func create(with model: KickboardDTO) {
        _ = model.toEntity(context: context)
        try? saveContext()
    }

    func fetch() -> [Kickboard] {
        let request: NSFetchRequest<Kickboard> = Kickboard.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    func delete(_ entity: Kickboard) {
        context.delete(entity)
        try? saveContext()
    }

    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func search(_ id: NSManagedObjectID) -> Entity? {
        do {
            let kickboard = try context.existingObject(with: id) as? Entity
            return kickboard
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func update(_ id: NSManagedObjectID, _ nickName: String, _ isSaddled: Bool) throws {
        guard let kickboard = search(id) else { return }
        kickboard.nickName = nickName
        kickboard.isSaddled = isSaddled
        try saveContext()
    }
    
    /// 내가 등록한 킥보드 fetch
    func fetchMyKickboards() -> [Kickboard] {
        let request: NSFetchRequest<Kickboard> = Kickboard.fetchRequest()
        
        // filter : isOccupied == true
        let isOccupiedPredicate = NSPredicate(format: "isOccupied == true")
        request.predicate = isOccupiedPredicate
        
        return (try? context.fetch(request)) ?? []
    }
}
