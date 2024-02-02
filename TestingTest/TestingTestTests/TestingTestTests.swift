//
//  TestingTestTests.swift
//  TestingTestTests
//
//  Created by Megan Schmoyer on 1/29/24.
//

import XCTest
@testable import TestingTest
final class TestingTestTests: XCTestCase {

    var testPerson: Person!
    
    let expectedName = "Cassandra"
    let expectedAge = 48
    let expectedHairColor = "Red"
    let expectedNumberOfPets = 8
    let expectedHasAHouse = true
    
    override func setUp() {
            super.setUp()
        testPerson = Person(name: expectedName,
        age: expectedAge,
        hairColor: expectedHairColor,
        numberOfPets: expectedNumberOfPets,
        hasAHouse: expectedHasAHouse)
        }
    
  
    

    func testPersonIdentity() {
        XCTAssertEqual(testPerson.name, expectedName)
        XCTAssertEqual(testPerson.age, expectedAge)
        XCTAssertEqual(testPerson.hairColor, expectedHairColor)
    }
    func testPersonPets() {
        XCTAssertLessThanOrEqual(testPerson.numberOfPets, 10)
    }
    func testPersonHouse() {
        XCTAssertTrue(expectedHasAHouse)
    }
    


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
