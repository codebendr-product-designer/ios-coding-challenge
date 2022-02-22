//
//  CountryListViewController.swift
//  Countries
//
//  Created by Syft on 03/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit
import CoreData

class CountryListViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView!
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 100
        countryTableView.dataSource = self
        countryTableView.accessibilityIdentifier = "CountryTable"
    }

}

extension CountryListViewController: UITableViewDataSource {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(in: view.window!)
        Server.shared.countryList { result in
            switch result {
            case let .success(countries):
                self.countries = countries?.sorted(by: >)
                HUD.dismiss(from: self.view.window!)
                self.countryTableView.reloadData()
            case let .failure(error):
                assertionFailure("There was an error: \(String(describing: error))")
            }
        }
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as! CountryTableViewCell
        
        if let country = countries?[indexPath.row] {
            cell.country = country
        }
        return cell
    }
    
}

