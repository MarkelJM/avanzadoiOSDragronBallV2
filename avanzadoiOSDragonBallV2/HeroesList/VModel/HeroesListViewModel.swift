//
//  HeroesListViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//


import Foundation
import  UIKit

class HeroesListViewModel {
    private let apiClient: ApiClient
    private let keychainManager = KeychainManager()
    
    var heroes: [HeroModel] = []
    
    var dataUpdated: (() -> Void)?
    
    init() {
        let token = keychainManager.readData()
        apiClient = ApiClient(token: token)
    }
    
    func getHeroesFromAPI(completion: @escaping ([HeroModel]) -> Void) {
        apiClient.getHeroes { [weak self] heroes, error in
            if let error = error {
                // Manejar el error
                print("Error fetching heroes: \(error.localizedDescription)")
            } else {
                var allHeroes: [HeroModel] = []
                /* Lo usaremos para manejar tareas asincronas ya que son muchos datos y debemos esperar a que lleguen todo*/
                let group = DispatchGroup()
                for hero in heroes {
                    group.enter()
                    self?.apiClient.getLocations(with: hero.id) { locations, error in
                        var fullHero = hero
                        if let firstLocation = locations.first {
                            fullHero.latitude = Double(firstLocation.latitude)
                            fullHero.longitude = Double(firstLocation.longitude)
                        } else {
                            fullHero.latitude = 0.0
                            fullHero.longitude = 0.0
                        }
                        allHeroes.append(fullHero)
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    self?.heroes = allHeroes
                    
                    // Guardar los datos en CoreData
                    for hero in allHeroes {
                        CoreDataUtils.storeHero(hero)
                    }
                    
                    // Notificar a la vista que los datos se han actualizado
                    self?.dataUpdated?()
                    
                    // Llamar al completion handler con los héroes obtenidos
                    completion(allHeroes)
                }
            }
        }
    }
    
    func logout() {
        // Eliminar el token del Keychain
        keychainManager.deleteData()
    }
}
