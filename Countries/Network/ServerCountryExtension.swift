//
//  ServerCountryExtension.swift
//  Countries
//
//  Created by Syft on 04/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

public enum CountryResult {
    case success([Country]?)
    case failure(Error?)
}

extension Server {
    
    func countryList(_ completion: @escaping (CountryResult) -> ()) {
        
        Server.shared.request(.get, path: "/all", object: Country.self) { (response: [Country]?, error) in
            
            guard error == nil else {
                completion(.failure(error))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(response))
            }
        }
    }
    
}
