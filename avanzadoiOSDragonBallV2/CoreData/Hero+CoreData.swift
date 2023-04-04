//
//  Hero+CoreData.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import Foundation
import CoreData

@objc(Hero)
public class Hero: NSManagedObject {
    
}

public extension Hero {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero")
    }
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var details: String
    @NSManaged var favorite: Bool
    @NSManaged var photo: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}

extension Hero: Identifiable {}
