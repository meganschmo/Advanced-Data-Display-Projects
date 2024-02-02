//
//  FakeStubMockData.swift
//  FakeStubMockLab
//
//  Created by Megan Schmoyer on 1/31/24.
//

import Foundation
 
protocol MathOperation {
  func add(_ a: Int, _ b: Int) -> Int
  func subtract(_ a: Int, _ b: Int) -> Int
}
class Calculator {
  let mathOperation: MathOperation
  init(mathOperation: MathOperation) {
    self.mathOperation = mathOperation
  }
  func add(_ a: Int, _ b: Int) -> Int {
    return mathOperation.add(a, b)
  }
  func subtract(_ a: Int, _ b: Int) -> Int {
    return mathOperation.subtract(a, b)
  }
}
class FakeMathOperation: MathOperation {
  func add( _ a: Int, _ b: Int) -> Int {
    return a + b
  }
  func subtract(_ a: Int, _ b: Int) -> Int {
    return a - b
  }
}
class StubMathOperation: MathOperation {
  func add(_ a: Int, _ b: Int) -> Int {
    return 10
  }
  func subtract(_ a: Int, _ b: Int) -> Int {
    return 5
  }
}
class MockMathOperation: MathOperation {
  var addCalled = false
  var subtractCalled = false
  func add(_ a: Int, _ b: Int) -> Int {
    addCalled = true
    return 0
  }
  func subtract(_ a: Int, _ b: Int) -> Int {
    subtractCalled = true
    return 0
  }
}
