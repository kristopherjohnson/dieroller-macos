# DieRoller Implementation Plan

All Swift/SwiftUI tasks should be delegated to `swift-expert` with the `apple-dev` skill loaded.

## Phase 1: Project Setup

- [x] 1.1 Create Xcode project: macOS App, SwiftUI lifecycle, Swift, name `DieRoller`, bundle id `com.krisjohnson.DieRoller` [agent: swift-expert] [skill: apple-dev]
- [x] 1.2 Set deployment target to macOS 26 (Tahoe), confirm `ARCHS = Standard Architectures` (arm64 + x86_64 universal), and enable App Sandbox with default entitlements [agent: swift-expert]
- [x] 1.3 Add `.gitignore` for Xcode (derived data, user state, xcuserdata) [parallel]
- [x] 1.4 Add minimal `README.md` describing what the app does and how to build it [parallel]

## Phase 2: Roll Engine (Model)

- [x] 2.1 Create `DieType` as `enum DieType: String, CaseIterable, Identifiable` with cases `d2, d4, d6, d8, d10, d12, d20, d100`, each exposing `faces: Int` and `label: String` (equal to the raw value, e.g., `"d20"`). `String` raw values are required so the enum can be stored via `@AppStorage` [agent: swift-expert] [parallel]
- [x] 2.2 Create `RollResult` struct (`Equatable`) with stored `dieType: DieType` and `values: [Int]`, plus computed `sum: Int` and computed `count: Int` (both derived from `values`) [agent: swift-expert] [parallel]
- [x] 2.3 Create `DiceRoller` type with `roll(count: Int, dieType: DieType) -> RollResult` using `SystemRandomNumberGenerator` via `Int.random(in: 1...faces)` [agent: swift-expert] [depends: 2.1, 2.2]
- [x] 2.4 Add input validation: clamp `count` to `1...10`, assert faces > 0 [agent: swift-expert] [depends: 2.3]

## Phase 3: UI (SwiftUI)

- [x] 3.1 Create `ContentView` state: `@AppStorage("selectedDieRaw") private var selectedDieRaw: String = DieType.d6.rawValue` and `@AppStorage("diceCount") private var diceCount: Int = 1`, plus `@State private var latestResult: RollResult? = nil`. Expose `selectedDie` as a computed var: `DieType(rawValue: selectedDieRaw) ?? .d6` (handles unknown/corrupted stored values). Clamp `diceCount` into `1...10` on view appearance (`onAppear`) so a stale UserDefaults value outside the range is normalized before first use [agent: swift-expert] [depends: 2.3]
- [x] 3.2 Build `ContentView` with die-type `Picker` (segmented), count `Picker` (segmented, one segment per value 1...10), `Roll` `Button` with `.keyboardShortcut(.defaultAction)`, and results area [agent: swift-expert] [depends: 3.1]
- [x] 3.3 Build `ResultsView` subview that shows placeholder text before first roll, individual values in a single `HStack` row using a large monospaced font, and a conditional Sum line when `count > 1` [agent: swift-expert] [depends: 3.1]
- [x] 3.4 Set minimum window size (`frame(minWidth: 400, minHeight: 300)`) and wire `ContentView` into `DieRollerApp.swift` [agent: swift-expert] [depends: 3.2]
- [x] 3.5 Verify dark mode and dynamic type look correct using SwiftUI previews [agent: swift-expert] [depends: 3.4]

## Phase 4: Testing

- [x] 4.1 Verify unit test target exists (Xcode macOS App template creates one by default); ensure the `DieRoller` scheme is marked **Shared** so `xcodebuild test` can find it [agent: swift-expert]
- [x] 4.2 Unit tests for `DiceRoller.roll`: correct count returned, all values in `[1, faces]`, sum matches `values.reduce(0, +)` [agent: swift-expert] [depends: 2.3, 4.1]
- [x] 4.3 Statistical smoke test: roll `d6` 10 000 times; assert every face `1...6` is observed [agent: swift-expert] [depends: 4.2]
- [x] 4.4 Verify `xcodebuild -scheme DieRoller -destination 'platform=macOS' test` runs cleanly [depends: 4.2, 4.3]

## Phase 5: Polish & Documentation

- [x] 5.1 Add a placeholder app icon (simple colored square or system-generated) to `Assets.xcassets` [agent: swift-expert]
- [ ] 5.1a Manual verification: quit and relaunch app, confirm `@AppStorage` restored the previously-selected die type and count [depends: 3.4]
- [ ] 5.2 Manual smoke test: build, run, roll each die type at counts 1 and 5, confirm results and sum behavior [depends: 3.5]
- [ ] 5.3 Update README with screenshots/usage once UI is final [depends: 5.2]

## Dependencies

- Xcode version with macOS 26 (Tahoe) SDK.
- No third-party Swift packages.

## Milestones

- **M1**: Project builds and launches to an empty window. (after Phase 1) ✓
- **M2**: Pure-Swift roll engine with passing unit tests. (after Phase 2 + 4.2) ✓
- **M3**: Fully functional UI, rolls displayed correctly. (after Phase 3) ✓
- **M4**: Tests green and README updated. (after Phase 5) — manual tests pending
