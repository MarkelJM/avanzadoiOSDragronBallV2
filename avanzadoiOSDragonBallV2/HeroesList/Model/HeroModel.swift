//
//  HeroModel.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import Foundation

struct HeroModel: Decodable {
    let photo: String
    let id: String
    let favorite: Bool
    let name: String
    let description: String
    var latitude: Double?
    var longitude: Double?
}
