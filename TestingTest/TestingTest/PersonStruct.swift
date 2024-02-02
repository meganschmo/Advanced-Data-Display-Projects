//
//  PersonStruct.swift
//  TestingTest
//
//  Created by Megan Schmoyer on 1/29/24.
//

import Foundation

struct Person {
    let name: String
    let age: Int
    let hairColor: String
    var numberOfPets: Int
    var hasAHouse: Bool
     
    init(name: String, age: Int, hairColor: String, numberOfPets: Int, hasAHouse: Bool) {
        self.name = name
        self.age = age
        self.hairColor = hairColor
        self.numberOfPets = numberOfPets
        self.hasAHouse = hasAHouse
    }
    mutating func isHouseless() {
        hasAHouse = false
    }
    mutating func notHouseless() {
        hasAHouse = true
    }
}
