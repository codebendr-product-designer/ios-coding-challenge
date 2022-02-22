//
//  Country.swift
//  Countries
//
//  Created by Syft on 04/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper


@objc(Country)
public class Country: NSManagedObject, Mappable, Comparable {
    
    public static func < (lhs: Country, rhs: Country) -> Bool {
        lhs.region! < rhs.region!
    }
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required public init?(map: Map) {
        super.init(entity: Self.entity(), insertInto: nil)
    }
    
    func mapping(map: Map) {
        
        DispatchQueue.main.async {
            self.name <- map["name"]
            self.capital <- map["capital"]
            self.population <- map["population"]
        }
    }
    
}
