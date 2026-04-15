// DiceRoller.swift — pure roll engine using SystemRandomNumberGenerator

import Foundation

/// Rolls dice using the system's cryptographically secure random source.
struct DiceRoller {
  /// Rolls `count` dice of `dieType`, clamping count to 1...10.
  func roll(count: Int, dieType: DieType) -> RollResult {
    precondition(dieType.faces > 0)
    let clampedCount = max(1, min(10, count))
    var rng = SystemRandomNumberGenerator()
    let values = (0..<clampedCount).map { _ in
      Int.random(in: 1...dieType.faces, using: &rng)
    }
    return RollResult(dieType: dieType, values: values)
  }
}
