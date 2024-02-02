//
//  Cats.swift
//  CatsAndMice
//
//  Created by Megan Schmoyer on 1/30/24.
//
//SOLI
import UIKit

 
import UIKit

protocol Runnable {
    var distance: Double { get set }
    func run() -> Double
}

protocol NoiseMaker {
    func makeNoise() -> Bool
}
// Interface Segregation Principle multiple protocols make it so that a class does not have to implement a method it does not need.
protocol Animal: Runnable, NoiseMaker {}

// Open/Closed Principle
class Cat: Runnable {
    var distance = 0.0
    
    func run() -> Double {
        distance += 2.0
        return distance
    }
}
    
class CatNoiseMaker: NoiseMaker {
    func makeNoise() -> Bool {
        if Bool.random() {
            print("Cat meows")
            return true
        }
        return false
    }
}


class Mouse: Runnable {
    var distance = 0.0
    
    func run() -> Double {
        distance += 1.5
        return distance
    }
}

class MouseNoiseMaker: NoiseMaker {
    func makeNoise() -> Bool {
        if Bool.random() {
            print("Mouse squeaks")
            return true
        }
        return false
    }
}
