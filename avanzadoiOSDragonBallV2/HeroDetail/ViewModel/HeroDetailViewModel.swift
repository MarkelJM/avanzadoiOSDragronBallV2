//
//  HeroDetailViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 1/5/23.
//
/*
import Foundation

class HeroDetailViewModel {
    private let apiClient: ApiClient
    
    var updateUI: ((_ hero: HeroModel?, _ error: String?) -> Void)?
    
    init() { // Pasamos el token como parámetro
        self.apiClient = ApiClient(token: token)
    }
    
    func getHeroDetail(name: String) {
        apiClient.getHeroByName(name: name) { [weak self] hero, error in
            guard error == nil else {
                self?.updateUI?(nil, "Se produjo un error al obtener los detalles del héroe")
                return
            }

            guard let hero = hero else {
                self?.updateUI?(nil, "Se produjo un error al obtener los detalles del héroe")
                return
            }
            
            self?.updateUI?(hero, nil)
        }
    }
}
*/






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
