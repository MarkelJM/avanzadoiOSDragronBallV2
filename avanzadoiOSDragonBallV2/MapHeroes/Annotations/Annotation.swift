//
//  Annotation.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation{
    let coordinate: CLLocationCoordinate2D
    let name : String
    let image: String
    let id: String

    init(place: HeroModel){
        
        coordinate = CLLocationCoordinate2D(latitude: place.latitude ?? 0.0
                                            , longitude: place.longitude ?? 0.0)
        name = place.name
        image = place.photo
        id = place.id

    }
}




/*
class Annotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let name: String
    let image: String
    let id: String
    
    init(hero: HeroModel) {
        coordinate = CLLocationCoordinate2D(latitude: hero.latitude ?? 0.0,
                                            longitude: hero.longitude ?? 0.0)
        id = hero.id
        name = hero.name
        image = hero.photo
    }
    
}
*/
