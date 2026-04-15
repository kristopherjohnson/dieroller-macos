// ContentView.swift — main UI for DieRoller

import SwiftUI

struct ContentView: View {
  @AppStorage("selectedDieRaw") private var selectedDieRaw: String = DieType.d6.rawValue
  @AppStorage("diceCount") private var diceCount: Int = 1
  @State private var latestResult: RollResult? = nil

  private let roller = DiceRoller()

  /// Derived selected die, falls back to d6 for unknown stored values.
  private var selectedDie: DieType {
    DieType(rawValue: selectedDieRaw) ?? .d6
  }

  private var rollHint: String {
    let noun = diceCount == 1 ? "die" : "dice"
    return "Rolls \(diceCount) \(selectedDie.label) \(noun)"
  }

  var body: some View {
    VStack(spacing: 16) {
      // Die type picker — segmented style. Label rendered explicitly so it
      // aligns with the Count label below at a consistent width.
      HStack {
        Text("Die Type")
          .frame(width: 70, alignment: .trailing)
        Picker("Die Type", selection: $selectedDieRaw) {
          ForEach(DieType.allCases) { die in
            Text(die.label)
              .accessibilityLabel("\(die.faces)-sided die")
              .tag(die.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .accessibilityLabel("Die type")
        .accessibilityValue("\(selectedDie.faces)-sided die")
      }

      // Count picker — segmented for fast single-click selection
      HStack {
        Text("Count")
          .frame(width: 70, alignment: .trailing)
        Picker("Count", selection: $diceCount) {
          ForEach(1...10, id: \.self) { n in
            Text("\(n)").tag(n)
          }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .accessibilityLabel("Number of dice")
        .accessibilityValue("\(diceCount)")
      }

      // Roll button — default keyboard action (Return)
      Button("Roll") {
        latestResult = roller.roll(count: diceCount, dieType: selectedDie)
      }
      .keyboardShortcut(.defaultAction)
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
      .accessibilityLabel("Roll")
      .accessibilityHint(rollHint)

      // Results
      ResultsView(result: latestResult)
    }
    .padding(20)
    .frame(width: 480, height: 300)
    .onAppear {
      // Clamp persisted count into valid range in case of stale defaults.
      diceCount = max(1, min(10, diceCount))
    }
  }
}

#Preview {
  ContentView()
}
