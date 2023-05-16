//
//  MapViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 13/4/23.
//


import Foundation
import CoreData
import UIKit




class MapViewModel: NSObject {
    
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
        
    var updateUI: ((_ hero: HeroModel, _ loc: [HeroMapModel]) -> Void)?
    
    override init() {
        super.init()
    }

    func getHeroesFromCoreData() -> [HeroModel] {
        let heroesFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        debugPrint("getherosfromcoredata:")
        debugPrint(heroesFetch)
        do {
            let result = try context.fetch(heroesFetch)
            
            if let heroes = convertToHeroModels(heroAPI: result) {
                return heroes
                
            }
        } catch let error as NSError {
            debugPrint("Error no hay nada en core data -> \(error)")
            return []
        }
        return []
    }
    
    func convertToHeroModels(heroAPI: [Hero]) -> [HeroModel]? {
        var heroList: [HeroModel] = []
        
        for hero in heroAPI {

            let id = hero.id
            let longitude = hero.longitude
            let latitude = hero.latitude
                
            let name = hero.name
            guard let photo = hero.photo else {
                return nil
            }
            let heroModel = HeroModel(photo: photo, id: id, favorite: false, name: name, description: "", latitude: latitude, longitude: longitude)
                
            debugPrint(hero)
            heroList.append(heroModel)
        }
        return heroList
    }
}


/*
class MapViewModel: NSObject {
    
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
        
    var updateUI: ((_ hero: HeroModel, _ loc: [HeroMapModel]) -> Void)?
    
    var keyChainContext = KeychainManager()

    override init() {
        super.init()
    }

    func fetchHeroLocations(hero: HeroModel, completion: @escaping ([HeroMapModel]) -> Void) {
            let apiClient = ApiClient(token: keyChainContext.readData())
            
            apiClient.getLocations(with: hero.id) { (locations: [HeroMapModel], error: Error?) in
                if let error = error {
                    print("Error fetching locations: \(error)")
                } else {
                    completion(locations)
                }
            }
        }


    func getHeroesFromCoreData() -> [HeroModel] {
        
        let heroesFetch: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            let result = try context.fetch(heroesFetch)
            
            if let heroes = convertToHeroModels(heroAPI: result) {
                return heroes
                
            }
        } catch let error as NSError {
            debugPrint("Error no hay nada en core data -> \(error)")
            return []
        }
        return []
    }
    
    func convertToHeroModels(heroAPI: [Hero]) -> [HeroModel]? {
        var heroList: [HeroModel] = []
        
        for hero in heroAPI {

            let id = hero.id
            let longitude = hero.longitude
            let latitude = hero.latitude
                
            let name = hero.name
            guard let photo = hero.photo else {
                return nil
            }
            let heroModel = HeroModel(photo: photo, id: id, favorite: false, name: name, description: "", latitude: latitude, longitude: longitude)
                
            debugPrint(hero)
            heroList.append(heroModel)
        }
        return heroList
    }
}


*/
