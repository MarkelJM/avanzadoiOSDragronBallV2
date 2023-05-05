//
//  CodeDataUtils.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 1/5/23.
//

import Foundation
import CoreData

class CoreDataUtils {
    
    static var context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    
    private static func storeHero(_ hero: HeroModel) {
        let heroDB = Hero(context: context)
        
        heroDB.id = hero.id
        heroDB.name = hero.name
        heroDB.favorite = hero.favorite
        heroDB.details = hero.description
        heroDB.photo = hero.photo
        heroDB.latitude = hero.latitude ?? 0.0
        heroDB.longitude = hero.longitude ?? 0.0
        
        do {
            
            try context.save()
            
        } catch let error {
            debugPrint(error)
        }
    }
    
    static func getData() -> [HeroModel] {
        let heroFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try context.fetch(heroFetch)
            //mapear
            let heroes = result.map {
                HeroModel.init(photo: $0.photo ?? "", id: $0.id, favorite: $0.favorite, name: $0.name, description: $0.details, latitude: $0.latitude, longitude: $0.longitude)
            }
            
            return heroes
         //errorr
        } catch let error as NSError {
            debugPrint("Error -> \(error)")
            return []
        }
    }
    static func getStoredHeroes() -> [Hero] {
        let heroeFetchDB: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try context.fetch(heroeFetchDB)
            return result
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
            return []
        }
    }
    
    
    static func deleteStoredHeroes() {
        /* traemos todos los datos*/
        var heroes = getStoredHeroes()
        
        heroes.forEach({ hero in
            context.delete(hero)
        })
        do {
            try context.save()
            
            let remainingHeroes = getStoredHeroes()
            debugPrint("Heroes remaining after deletion: \(remainingHeroes.count)")
            
        } catch let error as NSError {
            debugPrint("Error -> \(error.description)")
        }
    }
    
    

}
