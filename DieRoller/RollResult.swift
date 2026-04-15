// RollResult.swift — result of a single roll operation

import Foundation

/// The result of rolling one or more dice of the same type.
struct RollResult: Equatable {
  let dieType: DieType
  let values: [Int]

  /// Total of all rolled values.
  var sum: Int { values.reduce(0, +) }

  /// Number of dice rolled.
  var count: Int { values.count }
}
