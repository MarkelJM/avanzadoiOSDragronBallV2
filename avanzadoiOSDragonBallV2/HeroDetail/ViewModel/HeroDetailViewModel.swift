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
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext

    init(heroId: String) {
        self.heroId = heroId
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
}
