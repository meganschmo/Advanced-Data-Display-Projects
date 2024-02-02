//
//  FakeStubMockLabTests.swift
//  FakeStubMockLabTests
//
//  Created by Megan Schmoyer on 2/1/24.
//

import XCTest
@testable import FakeStubMockLab

final class FakeStubMockLabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculator_Addition() {
        let fakeMathOperation = FakeMathOperation()
        let calculator = Calculator(mathOperation: fakeMathOperation)
        XCTAssertEqual(calculator.add(10, 10), 20)
      }
      func testCalculator_Subtraction() {
        let fakeMathOperation = FakeMathOperation()
        let calculator = Calculator(mathOperation: fakeMathOperation)
        XCTAssertEqual(calculator.subtract(5, 3), 2)
      }
      func testCalculator_Stub_Addition() {
        let stubMathOperation = StubMathOperation()
        let calculator = Calculator(mathOperation: stubMathOperation)
        XCTAssertEqual(calculator.add(100, 3), 10)
      }
      func testCalculator_Stub_Subtraction() {
        let stubMathOperation = StubMathOperation()
        let calculator = Calculator(mathOperation: stubMathOperation)
        XCTAssertEqual(calculator.subtract(200, 1), 5)
      }
      func testCalculator_Mock_Addition() {
        let mockMathOperation = MockMathOperation()
        let calculator = Calculator(mathOperation: mockMathOperation)
        _ = calculator.add(2, 3)
        XCTAssertTrue(mockMathOperation.addCalled)
      }
      func testCalculator_Mock_Subtraction() {
        let mockMathOperation = MockMathOperation()
        let calculator = Calculator(mathOperation: mockMathOperation)
        _ = calculator.subtract(5, 3)
        XCTAssertTrue(mockMathOperation.subtractCalled)
      }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
