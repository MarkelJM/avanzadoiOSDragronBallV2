//
//  Place.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

import Foundation

struct HeroMapModel: Decodable {
    
    let name: String
    let latitude: Double
    let longitude:Double

}

extension HeroMapModel {
    func toHeroModel() -> HeroModel {
        return HeroModel(
            photo: "",
            id: UUID().uuidString,
            favorite: false,
            name: self.name,
            description: "",
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
}



