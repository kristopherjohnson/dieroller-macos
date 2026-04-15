# Decision Log

2026-04-10 | SPECIFICATION.md | Initial creation from user description: macOS die-roller app, die types d2/d4/d6/d8/d10/d12/d20/d100, count + Roll button, display rolls and sum when count > 1
2026-04-10 | SPECIFICATION.md | Inferred SwiftUI + Swift on macOS 14 as default target (pending confirmation)
2026-04-10 | SPECIFICATION.md | Inferred dice count range 1...100 (pending confirmation)
2026-04-10 | SPECIFICATION.md | Inferred no persistence of selected die/count across launches for v1 (pending confirmation)
2026-04-10 | IMPLEMENTATION_PLAN.md | Structured as 5 phases: setup, roll engine, UI, testing, polish; Swift tasks annotated for swift-expert agent
2026-04-10 | SPECIFICATION.md | Confirmed: deployment target is macOS 26 (Tahoe)
2026-04-10 | SPECIFICATION.md | Confirmed: maximum dice count is 10 (range 1...10)
2026-04-10 | SPECIFICATION.md | Confirmed: use @AppStorage to persist selected die type and count across launches
2026-04-10 | SPECIFICATION.md | Confirmed: with max count of 10, render results as a single horizontal row of values
2026-04-10 | IMPLEMENTATION_PLAN.md | Confirmed: use a placeholder app icon for v1
2026-04-10 | IMPLEMENTATION_PLAN.md | Replaced RollViewModel with @AppStorage-backed @State in ContentView — simpler given no view-model logic beyond wiring
2026-04-10 | SPECIFICATION.md | Review fix (B1): macOS 26 is Apple Silicon only; removed "Intel universal binary" claim
2026-04-10 | SPECIFICATION.md | Review fix (B3): removed Space as Roll shortcut; Return only (via .defaultAction)
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (B2): DieType declared as String-backed enum for @AppStorage compatibility
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (A1, P2): RollResult count is computed; struct is Equatable
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (A2, A3): ContentView clamps loaded diceCount to 1...10 onAppear; selectedDie computed with .d6 fallback for unknown raw values
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (A5): Picker starts with .segmented, falls back to .menu if cramped at minimum width
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (P1): task 5.1a now depends on 3.4 instead of 3.1
2026-04-10 | IMPLEMENTATION_PLAN.md | Review fix (P4, P5): task 4.1 reworded to verify test target and share the scheme
2026-04-10 | TEST_PLAN.md | Review fix (P3): removed unreachable "empty values" edge case; added Equatable sanity check
2026-04-10 | SPECIFICATION.md | User correction: macOS 26 Tahoe supports some Intel Macs; restored universal binary (arm64 + x86_64) — reverses earlier B1 fix which was based on outdated information
2026-04-10 | IMPLEMENTATION_PLAN.md | Task 1.2 updated to confirm Standard Architectures (universal) build setting
2026-04-10 | TEST_PLAN.md | Added integration check: verify built binary is universal via `lipo -info`
2026-04-10 | IMPLEMENTATION_PLAN.md | Used xcodegen to generate .xcodeproj from project.yml (xcodegen available at /opt/homebrew/bin/xcodegen)
2026-04-10 | IMPLEMENTATION_PLAN.md | Set ARCHS="arm64 x86_64" and ONLY_ACTIVE_ARCH=NO explicitly in project-wide base settings. ARCHS_STANDARD on macOS 26/Xcode 26.4 only builds arm64 in Debug (active arch optimization). Explicit ARCHS ensures universal binary in all configs. Verified with lipo -info.
2026-04-10 | IMPLEMENTATION_PLAN.md | Segmented picker retained for die type — all 8 segments fit comfortably at 400pt minimum width on macOS 26.
2026-04-10 | IMPLEMENTATION_PLAN.md | Swift 6 used (SWIFT_VERSION=6.0). No MainActor annotations needed; roll engine is sync and structs are value types.
2026-04-10 | IMPLEMENTATION_PLAN.md | App icon placeholder: empty AppIcon.appiconset (Contents.json only, no image files). Builds cleanly; shows generic icon at runtime.
2026-04-14 | SPECIFICATION.md, DieRollerApp.swift | App terminates when its window is closed — implemented via NSApplicationDelegateAdaptor returning true from applicationShouldTerminateAfterLastWindowClosed
2026-04-14 | SPECIFICATION.md, TEST_PLAN.md, ContentView.swift, DieRollerApp.swift | Window is fixed at 480 × 300 pt (not resizable). Switched ContentView to .frame(width:height:) and scene to .windowResizability(.contentSize). Updated manual test M7 and removed "very narrow window" edge case.
2026-04-14 | ContentView.swift, ResultsView.swift | Added accessibility labels/values/hints: picker reads "Die type, N-sided die"; segment elements read "N-sided die" (instead of literal "d20"); stepper reads "Number of dice" with current value; Roll button announces dynamic hint ("Rolls 3 d20 dice"); results HStack collapsed into one accessibility element with phrase like "Rolled 3 d20: 4, 12, 7"; sum reads "Sum 23"; placeholder reads "No roll yet. Press Roll to roll dice."
2026-04-14 | SPECIFICATION.md, TEST_PLAN.md, IMPLEMENTATION_PLAN.md, ContentView.swift | Replaced count Stepper with a 10-segment .segmented Picker for faster single-click count selection. Ten segments at the fixed 480 pt window width are readable for single-digit values. Manual test M10 reworded; "stepper refuses at bounds" no longer applies.
2026-04-14 | DieRoller/Info.plist | Added CFBundleDisplayName = "Die Roller" so the user-facing app name (menu bar, About, Finder) reads with a space. PRODUCT_NAME, target name, and bundle id remain "DieRoller" / com.krisjohnson.DieRoller.
<!-- LOG_END -->
