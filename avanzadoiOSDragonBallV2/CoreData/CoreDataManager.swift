//
//  CoreDataManager.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

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
        debugPrint("prueba 12")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Error during saving context \(error)")
        }
    }
}
    /*
    func storeHero(_ id: String, _ name: String, _ details: String, _ photo: String, _ longitude: String, _ latitude: String) {
        let heroe = Hero(context: self.managedContext)
        debugPrint("prueba 10")
        
        
        heroe.id = id
        heroe.photo = photo
        heroe.name = name
        heroe.details = details
        heroe.longitude = Double(longitude) ?? 0.0
        heroe.latitude = Double(latitude) ?? 0.0
        
        do {
            try self.managedContext.save()
        } catch let error {
            debugPrint(error)
            debugPrint("prueba 13")
            
        }
        debugPrint("prueba 11")
        
    }
     */

// creamos clas para hacerla "static", ya que static de normal me da error
/*
class func getStoredHeroes() -> [Hero] {
    let heroeFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
    
    do {
        let result = try self.shared.managedContext.fetch(heroeFetch)
        return result
        
    } catch let error as NSError {
        debugPrint("Error -> \(error.description)")
        return []
    }
}
*/
/*
    // creamos clas para hacerla "static", ya que static de normal me da error
class func deleteStoredHeroes() {
    let heroes = try! self.shared.managedContext.fetch(Hero.fetchRequest())
    
    heroes.forEach({ hero in
        self.shared.managedContext.delete(hero)
    })
    do {
        try self.shared.managedContext.save()
        
    } catch let error as NSError {
        debugPrint("Error -> \(error.description)")
    }
    
}
*/
//  propiedad estática "shared" para almacenar una instancia compartida de la clase
//static let shared = CoreDataManager(modelName: "Model")





 /*
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
 */


/*

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
    static func getStoredHeroes() -> [Hero] {
        let heroeFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try self.managedContext.fetch(heroeFetch)
            return result
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
            return []
        }
    }

    static func deleteStoredHeroes() {
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
    
    
}
/* sacamos fuera de la clase para poder acceder sin problemas en el controller da la tabla: tengo que instanciar CDMnager y me da errores*/
*/
