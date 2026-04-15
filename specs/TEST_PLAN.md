# DieRoller Test Plan

## Unit Tests

### DieType
- Each case reports the correct `faces` value (d2→2, d4→4, d6→6, d8→8, d10→10, d12→12, d20→20, d100→100).
- Each case reports the correct `label` (e.g., `d20`).

### RollResult
- `sum` equals the reduced sum of `values`.
- `count` equals `values.count`.
- Two `RollResult`s with the same `dieType` and `values` are `==` (Equatable conformance sanity check).

### DiceRoller
- `roll(count: 1, dieType: .d6)` returns exactly 1 value in `1...6`.
- `roll(count: 5, dieType: .d20)` returns exactly 5 values, each in `1...20`.
- `roll(count: 10, dieType: .d100)` returns 10 values, each in `1...100`.
- `roll` with `count` below 1 is clamped to 1.
- `roll` with `count` above 10 is clamped to 10.
- Statistical smoke test: 10 000 rolls of a d6 observe all six faces at least once.

## Integration Tests

- Building the `DieRoller` scheme succeeds on macOS 26 (Tahoe) with the current Xcode.
- The produced binary is universal (arm64 + x86_64); verify with `lipo -info` or `file` on the built `.app/Contents/MacOS/DieRoller` binary.
- `xcodebuild test` runs the unit-test target cleanly.

## Manual Tests

Run the app and verify each case:

| # | Action | Expected |
|---|--------|----------|
| M1 | Launch app | Single window, default die `d6`, count `1`, results area shows placeholder text |
| M2 | Click Roll with default settings | A single integer in `1...6` is displayed, no sum shown |
| M3 | Select `d20`, count `3`, click Roll | Three integers in `1...20` displayed plus `Sum: X` |
| M4 | Select `d100`, count `1`, click Roll | One integer in `1...100` displayed, no sum |
| M5 | Press Return key instead of clicking Roll | Same behavior as clicking Roll |
| M6 | Toggle system appearance (light ↔ dark) | UI remains legible in both modes |
| M7 | Try to resize window | Window is fixed at 480 × 300; resize handles absent / no-op |
| M8 | Roll each die type at count 1 | Each reports a value in its expected range |
| M9 | Select `d20` with count `7`, quit app, relaunch | On launch the picker shows `d20` and count shows `7` (persistence) |
| M10 | Click each segment of the Count picker (1–10) | The selected count updates immediately on every click |

## Edge Cases

- Count = 1 → no sum line shown.
- Count = 10 → all ten values render comfortably on one line at the fixed 480 pt window width.
- Rapid repeated clicks on Roll → each click produces a new result; no crashes or UI glitches.
- First launch with no stored defaults → picker defaults to `d6`, count defaults to `1`.
- Corrupted / unknown stored die type string → falls back to `d6` gracefully.

## Performance Tests

Not a focus for v1. Informally verify that rolling 10 × d100 completes instantly (< 1 ms, single-threaded).

## Test Commands

```sh
# Build + run all unit tests
xcodebuild -scheme DieRoller -destination 'platform=macOS' test
```

## Status

All tests pending — no implementation yet.
