//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Syft on 05/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    override func prepareForReuse() {
        capitalLabel.text = .none
        populationLabel.text = .none
        regionLabel.text = .none
        areaLabel.text = .none
    }
    
    var country: Country? {
        didSet {
            if let country = country {
                capitalLabel.text = country.capital
                populationLabel.text = "\(country.population.commas())"
                areaLabel.text = "\(country.area)"
                regionLabel.text = country.region
                accessibility(with: country.name ?? "name")
            }
        }
    }
    
    func accessibility(with name: String) {
        accessibilityIdentifier = "\(name)-Cell"
        countryLabel.accessibilityIdentifier = "Country"
        capitalLabel.accessibilityIdentifier = "\(name)-Capital-Label"
        populationLabel.accessibilityIdentifier = "\(name)-Population-Label"
    }
    
}
