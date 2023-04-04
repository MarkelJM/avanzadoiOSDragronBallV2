//
//  CoreDataManager.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//
/*
import Foundation
import CoreData

class CoreDataManager {
    
    private let modelName : String
    
    init(modelName: String){
        self.modelName = modelName
        
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error {
                debugPrint("Error during loading persistent stores \(error)")
            }
            
        }
        return container
    }()
    
    lazy var managedContext : NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return}
        
        do {
            try managedContext.save()

        } catch let error as NSError {
            debugPrint("Error during saving context \(error)")
        }
    }
    
    func storeHero(_ id: String, _ name: String, _ heroDescription: String,_ photo: String, _ longitud: String, _ latitud: String) {
        
        let heroe = Hero(context: contextHeroes)
        let location = Location(context: contextHeroes)
        
        location.latitud = latitud
        location.longitud = longitud
        
        heroe.id = id
        heroe.photo = photo
        heroe.name = name
        heroe.heroDescription = heroDescription
        heroe.toLocation = location
     
        
        do {
            try contextHeroes.save()
        } catch let error {
            debugPrint(error)
        }
        
    }

    func getStoredHeroes() -> [Hero] {
        let heroeFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try contextHeroes.fetch(heroeFetch)
            return result
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
            return []
        }
    }
    func deleteAllHeroes() {
        let context = AppDelegate.sharedAppDelegate.CoreDataManager.managedContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hero")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            debugPrint("Error during deleting heroes from context \(error)")
        }
    }
}

*/

import Foundation
import CoreData

class CoreDataManager {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _ , error in
            if let error {
                debugPrint("Error during loading persistent stores \(error)")
            }
        }
        
        return container
    }()
    
    lazy var managedContext : NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Error during saving context \(error)")
        }
    }
    
    func storeHero(_ id: String, _ name: String, _ details: String,_ photo: String, _ longitud: String, _ latitud: String) {
        
        let heroe = Hero(context: self.managedContext)
        
        //let location = Location(context: self.managedContext)
        
        //location.latitud = latitud
        //location.longitud = longitud
        
        heroe.id = id
        heroe.photo = photo
        heroe.name = name
        heroe.details = details
        //heroe.toLocation = location
        
        do {
            try self.managedContext.save()
        } catch let error {
            debugPrint(error)
        }
        
    }
    
    func getStoredHeroes() -> [Hero] {
        let heroeFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try self.managedContext.fetch(heroeFetch)
            return result
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
            return []
        }
    }
    
    func deleteStoredHeroes() {
        let heroes = try! self.managedContext.fetch(Hero.fetchRequest())
        
        heroes.forEach({ hero in
            self.managedContext.delete(hero)
        })
        do {
            try self.managedContext.save()
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
        }
        
    }
}


