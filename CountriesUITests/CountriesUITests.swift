//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Syft on 03/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import XCTest

class CountriesUITests: XCTestCase {

    let kTimeOut = 10.0
    
    func testPopulationFormat() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // The purpose of this test is to check that the population is formatted with comma separators.
        // It assumes a UK locale, and:
        //   1,000,000 <= Afghan population <= 999,999,999.
        //   1,000,000,000 <= China population <= 999,999,999,999
        //   1,000 <= Antarctica population <= 9,999
        
        let afghanPopulation = app.staticTexts["Afghanistan-Population"]
        XCTAssertTrue(afghanPopulation.waitForExistence(timeout: kTimeOut))
        var commas = afghanPopulation.label.filter({return $0 == ","}).count
        XCTAssertEqual(2, commas)
        
        let chinaPopulation = app.staticTexts["China-Population"]
        XCTAssertTrue(afghanPopulation.waitForExistence(timeout: kTimeOut))
        commas = chinaPopulation.label.filter({return $0 == ","}).count
        XCTAssertEqual(3, commas)
        
        let antarcticaPopulation = app.staticTexts["Antarctica-Population"]
        XCTAssertTrue(antarcticaPopulation.waitForExistence(timeout: kTimeOut))
        commas = antarcticaPopulation.label.filter({return $0 == ","}).count
        XCTAssertEqual(1, commas)
    }

    func testCapitals() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // The purpose of this test is to check cpital cities are correct,
        // and that we don't try and display non-existent capitals, such as for Antarctica.
        
        let algeriaCapital = app.staticTexts["Algeria-Capital"]
        XCTAssertTrue(algeriaCapital.waitForExistence(timeout: kTimeOut))
        XCTAssertEqual("Algiers", algeriaCapital.label)
        
        let andorraCapital = app.staticTexts["Andorra-Capital"]
        XCTAssertTrue(andorraCapital.waitForExistence(timeout: kTimeOut))
        XCTAssertEqual("Andorra la Vella", andorraCapital.label)

        let antarcticaCapital = app.staticTexts["Antarctica-Capital-Label"]
        XCTAssertFalse(antarcticaCapital.waitForExistence(timeout: kTimeOut))
    }
    
    func testOrder() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // The purpose of this test is to check the countries are displayed in alphabetical order.
        // Pick ten countries at random in ascending order of table index and confirm that the countries
        // are in ascending order too.
        let table = app.tables["CountryTable"]
        XCTAssertTrue(table.waitForExistence(timeout: kTimeOut))
        let cells = table.cells.allElementsBoundByIndex
        
        var indexes = Set<UInt32>()
        while indexes.count < 10 {
            indexes.insert(arc4random_uniform(UInt32(cells.count)))
        }
        
        let orderedIndexes = Array(indexes).sorted()
        let countries = orderedIndexes.map { (index) -> String in
            return cells[Int(index)].staticTexts["Country"].label
        }
        
        let orderedCountries = countries.sorted()
        XCTAssertEqual(countries, orderedCountries)
    }
    
}
