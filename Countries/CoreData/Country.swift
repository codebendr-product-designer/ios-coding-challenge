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
        lhs.name! < rhs.name!
    }
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required public init?(map: Map) {
        super.init(entity: Self.entity(), insertInto: nil)
    }
    
    public func mapping(map: Map) {
        if let capital = map.JSON["capital"] as? [String] {
            if let capital = capital.first {
                self.capital = capital
            }
        }
        self.name <- map["name.common"]
        self.population <- map["population"]
        self.area <- map["area"]
        self.region <- map["region"]
    }
    
}
