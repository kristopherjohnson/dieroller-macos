// DieType.swift — supported die types for DieRoller

import Foundation

/// All supported die types. String raw values allow @AppStorage persistence.
enum DieType: String, CaseIterable, Identifiable {
  case d2
  case d4
  case d6
  case d8
  case d10
  case d12
  case d20
  case d100

  var id: String { rawValue }

  /// Number of faces on this die.
  var faces: Int {
    switch self {
    case .d2: return 2
    case .d4: return 4
    case .d6: return 6
    case .d8: return 8
    case .d10: return 10
    case .d12: return 12
    case .d20: return 20
    case .d100: return 100
    }
  }

  /// Display label (matches raw value).
  var label: String { rawValue }
}
