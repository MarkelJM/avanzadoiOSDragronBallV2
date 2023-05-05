//
//  HeroesListViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//



import Foundation

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
                    self?.heroes = heroes
                    
                    // Guardar los datos en CoreData
                    
                    // Notificar a la vista que los datos se han actualizado
                    self?.dataUpdated?()
                    
                    // Llamar al completion handler con los héroes obtenidos
                    completion(heroes)
                }
            }
        }

    
    func logout() {
        // Eliminar el token del Keychain
        keychainManager.deleteData()
    }
}



/*
import Foundation
import CoreData

class HeroesListViewModel: NSObject {
    /*de momenoto no lo uso*/
    let context = AppDelegate.sharedAppDelegate.coreDataManager.managedContext

    private var apiClient: ApiClient?
    let keychainManager = KeychainManager()
        
    override init() {
        apiClient = ApiClient(token: keychainManager.readData())
    }
    
    
    var updateUI: ((_ heroesList: [HeroModel]) -> Void)?
    /*
    func getData() {
        let apiClient = ApiClient(token: keychainManager.readData())
        apiClient.getHeroes { [weak self] heroes, error in
            self?.updateUI?(heroes)
        }
    }
     */
    func getHeroesData(completion: @escaping ([HeroModel]) -> Void) {
        let storedHeroes = CoreDataUtils.getStoredHeroes()
        debugPrint("prueba 1")
    

        if storedHeroes.isEmpty {
            apiClient?.getHeroes { [weak self] heroes, error in
                    for hero in heroes {
                        let longitude = hero.longitude != nil ? String(hero.longitude!) : nil
                        let latitude = hero.latitude != nil ? String(hero.latitude!) : nil
                        CoreDataManager.shared.storeHero(hero.id, hero.name, hero.description, hero.photo, longitude ?? "0.0", latitude ?? "0.0")
                    }
                    self?.updateUI?(heroes)
                }
        } else {
            let heroes = storedHeroes.map { hero in
                        return HeroModel(
                            photo: hero.photo ?? "",
                            id: hero.id,
                            favorite: hero.favorite,
                            name: hero.name,
                            description: hero.details,
                            latitude: hero.latitude != 0 ? hero.latitude : nil,
                            longitude: hero.longitude != 0 ? hero.longitude : nil
                        )
                    }
            debugPrint("prueba 2")

            completion(heroes)
            debugPrint("prueba 3")

        }
    }
    
}
*/
