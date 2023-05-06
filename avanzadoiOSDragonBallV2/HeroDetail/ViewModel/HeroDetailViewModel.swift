//
//  HeroDetailViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 1/5/23.
//

import Foundation
import CoreData

class DetailViewModel {
    let heroId: String
    /*taer datos coredata*/
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext
    /*como me da errores traeremos desde api*/
    var updateUI: ((_ hero: HeroModel?, _ error: String) -> Void)?
    private var apiClient: ApiClient?
    let token = KeychainManager().readData()
    init(heroId: String) {
        self.heroId = heroId
        self.apiClient = ApiClient(token: token)
    }
    
    func getHeroDetails(completion: @escaping (HeroModel?) -> Void) {
        let fetchRequest: NSFetchRequest<Hero> = Hero.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", heroId)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let hero = result.first {
                let heroModel = HeroModel(
                    photo: hero.photo ?? "",
                    id: hero.id ?? "",
                    favorite: hero.favorite,
                    name: hero.name ?? "",
                    description: hero.details ?? "",
                    latitude: hero.latitude,
                    longitude: hero.longitude
                )
                completion(heroModel)
            } else {
                completion(nil)
            }
        } catch {
            debugPrint("Error fetching hero from CoreData: \(error.localizedDescription)")
            completion(nil)
        }
    }
    /*
    func getHeroDetailsFromAPI(completion: @escaping (HeroModel?) -> Void) {
        // Utilizamos el método getHeroByName del ApiClient para obtener el héroe por su nombre
        apiClient.getHeroByName(name: heroId) { hero, error in
            if let error = error {
                debugPrint("Error fetching hero from API: \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let hero = hero {
                completion(hero)
            } else {
                completion(nil)
            }
        }
    }
    */
    func getHeroDetailsFromAPI(name: String) {
            guard let apiClient = self.apiClient else { return  }
                    
            apiClient.getHeroByName(name: name) { [weak self] hero, error  in
                
                guard error == nil else {
                    self?.updateUI?(nil, "erro al trear heros de la api")
                    return
                }

                guard let hero = hero else {
                    self?.updateUI?(nil, "erro al trear heros de la api V2")
                    return
                }
                
                
                self?.updateUI?(hero, "")
            }
        }
}







/*
class HeroDetailViewModel {
    private(set) var hero: HeroModel

    init(hero: HeroModel) {
        self.hero = hero
    }

    var name: String {
        return hero.name
    }

    var description: String {
        return hero.description
    }

    var photoURL: URL? {
        return URL(string: hero.photo)
    }
 
 
}
*/
