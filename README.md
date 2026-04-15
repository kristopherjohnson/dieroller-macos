# DieRoller

A simple native macOS app for rolling virtual dice during tabletop games.

## Features

- Supports d2, d4, d6, d8, d10, d12, d20, and d100.
- Roll 1–10 dice at once; individual results and sum are shown.
- Press **Return** to roll (keyboard-first design).
- Selected die type and count persist across launches.
- Universal binary (Apple Silicon + Intel).

## Requirements

- macOS 26 (Tahoe) or later
- Xcode 26.x

## Building

```sh
# Generate Xcode project (requires xcodegen)
xcodegen generate

# Build from command line
xcodebuild -scheme DieRoller -configuration Release build

# Run unit tests
xcodebuild -scheme DieRoller -destination 'platform=macOS' test
```

Or open `DieRoller.xcodeproj` in Xcode and press ⌘R.

