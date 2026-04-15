# DieRoller Open Issues

## Questions Needing Answers

None — all questions resolved. See DECISION_LOG.md.

## Bugs to Fix

None yet — no implementation.

## Decisions Pending

None.

## Research Needed

None. All functionality uses standard Swift/SwiftUI APIs.

## Notes

- Random number source: `Int.random(in:)` (uses `SystemRandomNumberGenerator`, cryptographically secure).
- With max count of 10, the results view renders all values on a single horizontal row — no scrolling or wrapping required.
- Since the project directory is currently empty, `/spec implement` will begin with Xcode project creation.
