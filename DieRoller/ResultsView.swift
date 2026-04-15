// ResultsView.swift — displays roll results or a placeholder before the first roll

import SwiftUI

struct ResultsView: View {
  let result: RollResult?

  var body: some View {
    Group {
      if let result {
        VStack(spacing: 8) {
          // Individual values in a horizontal row.
          // Combined into one accessibility element so VoiceOver reads the
          // whole roll as a single phrase ("Rolled 4, 2, 6") rather than
          // navigating value-by-value.
          HStack(spacing: 12) {
            ForEach(Array(result.values.enumerated()), id: \.offset) { _, value in
              Text("\(value)")
                .font(.system(.largeTitle, design: .monospaced, weight: .bold))
            }
          }
          .frame(maxWidth: .infinity)
          .accessibilityElement(children: .ignore)
          .accessibilityLabel(rollLabel(for: result))

          // Sum line — only when more than one die was rolled
          if result.count > 1 {
            Text("Sum: \(result.sum)")
              .font(.title2)
              .foregroundStyle(.secondary)
              .accessibilityLabel("Sum \(result.sum)")
          }
        }
      } else {
        Text("Press Roll to roll dice")
          .foregroundStyle(.secondary)
          .font(.title3)
          .accessibilityLabel("No roll yet. Press Roll to roll dice.")
      }
    }
    .frame(maxWidth: .infinity, minHeight: 80)
    .multilineTextAlignment(.center)
  }

  private func rollLabel(for result: RollResult) -> String {
    let values = result.values.map(String.init).joined(separator: ", ")
    if result.count == 1 {
      return "Rolled \(values) on a \(result.dieType.label)"
    }
    return "Rolled \(result.count) \(result.dieType.label): \(values)"
  }
}

#Preview("No result") {
  ResultsView(result: nil)
    .padding()
}

#Preview("Single die") {
  ResultsView(result: RollResult(dieType: .d6, values: [4]))
    .padding()
}

#Preview("Multiple dice") {
  ResultsView(result: RollResult(dieType: .d20, values: [7, 14, 3, 19, 11]))
    .padding()
}
