//
//  HeroesListViewModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//

import Foundation

class HeroesListViewModel: NSObject {
    
    private var apiClient: ApiClient?
    let keychainManager = KeychainManager()
    
    override init() {

    }
    
    var updateUI: ((_ heroesList: [HeroModel]) -> Void)?
    
    func getData() {
        let apiClient = ApiClient(token: keychainManager.readData())
        apiClient.getHeroes { [weak self] heroes, error in
            self?.updateUI?(heroes)
        }
    }
    
}
