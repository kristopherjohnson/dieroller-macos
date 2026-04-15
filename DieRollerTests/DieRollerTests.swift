// DieRollerTests.swift — unit tests for the DieRoller roll engine

import XCTest

@testable import DieRoller

final class DieTypeTests: XCTestCase {
  func testFaces() {
    XCTAssertEqual(DieType.d2.faces, 2)
    XCTAssertEqual(DieType.d4.faces, 4)
    XCTAssertEqual(DieType.d6.faces, 6)
    XCTAssertEqual(DieType.d8.faces, 8)
    XCTAssertEqual(DieType.d10.faces, 10)
    XCTAssertEqual(DieType.d12.faces, 12)
    XCTAssertEqual(DieType.d20.faces, 20)
    XCTAssertEqual(DieType.d100.faces, 100)
  }

  func testLabels() {
    XCTAssertEqual(DieType.d2.label, "d2")
    XCTAssertEqual(DieType.d20.label, "d20")
    XCTAssertEqual(DieType.d100.label, "d100")
  }
}

final class RollResultTests: XCTestCase {
  func testSum() {
    let result = RollResult(dieType: .d6, values: [1, 2, 3])
    XCTAssertEqual(result.sum, 6)
  }

  func testCount() {
    let result = RollResult(dieType: .d6, values: [4, 5])
    XCTAssertEqual(result.count, 2)
  }

  func testEquatable() {
    let a = RollResult(dieType: .d6, values: [1, 2, 3])
    let b = RollResult(dieType: .d6, values: [1, 2, 3])
    let c = RollResult(dieType: .d6, values: [1, 2, 4])
    XCTAssertEqual(a, b)
    XCTAssertNotEqual(a, c)
  }
}

final class DiceRollerTests: XCTestCase {
  private let roller = DiceRoller()

  func testSingleD6ValueInRange() {
    let result = roller.roll(count: 1, dieType: .d6)
    XCTAssertEqual(result.count, 1)
    XCTAssertTrue((1...6).contains(result.values[0]))
  }

  func testFiveD20ValuesInRange() {
    let result = roller.roll(count: 5, dieType: .d20)
    XCTAssertEqual(result.count, 5)
    for value in result.values {
      XCTAssertTrue((1...20).contains(value), "Value \(value) out of range for d20")
    }
  }

  func testTenD100ValuesInRange() {
    let result = roller.roll(count: 10, dieType: .d100)
    XCTAssertEqual(result.count, 10)
    for value in result.values {
      XCTAssertTrue((1...100).contains(value), "Value \(value) out of range for d100")
    }
  }

  func testSumMatchesValues() {
    let result = roller.roll(count: 5, dieType: .d6)
    XCTAssertEqual(result.sum, result.values.reduce(0, +))
  }

  func testCountClampedBelow() {
    // count below 1 is clamped to 1
    let result = roller.roll(count: 0, dieType: .d6)
    XCTAssertEqual(result.count, 1)
  }

  func testCountClampedAbove() {
    // count above 10 is clamped to 10
    let result = roller.roll(count: 99, dieType: .d6)
    XCTAssertEqual(result.count, 10)
  }

  func testNegativeCountClamped() {
    let result = roller.roll(count: -5, dieType: .d6)
    XCTAssertEqual(result.count, 1)
  }

  // Statistical smoke test: roll d6 10,000 times; all faces must be observed.
  func testStatisticalSmoke() {
    var observed = Set<Int>()
    for _ in 0..<10_000 {
      let result = roller.roll(count: 1, dieType: .d6)
      observed.insert(result.values[0])
    }
    for face in 1...6 {
      XCTAssertTrue(observed.contains(face), "Face \(face) never observed in 10,000 rolls")
    }
  }
}
