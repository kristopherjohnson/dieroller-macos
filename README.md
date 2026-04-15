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

The generated `DieRoller.xcodeproj` is committed, so you can build immediately:

```sh
# Build from command line
xcodebuild -scheme DieRoller -configuration Release build

# Run unit tests
xcodebuild -scheme DieRoller -destination 'platform=macOS' test
```

Or open `DieRoller.xcodeproj` in Xcode and press ⌘R.

### Regenerating the Xcode project

The project is defined by `project.yml` and generated with [xcodegen](https://github.com/yonaskolb/XcodeGen). Run `xcodegen generate` only after:

- Editing `project.yml` (build settings, bundle id, targets, etc.).
- Adding or removing source files under `DieRoller/` or `DieRollerTests/` — xcodegen globs sources from disk, so the `.xcodeproj` must be regenerated to pick them up.

```sh
brew install xcodegen   # if not already installed
xcodegen generate
```

