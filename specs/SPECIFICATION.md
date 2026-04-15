# DieRoller Specification

## Overview

DieRoller is a simple native macOS application for rolling virtual dice during tabletop games. The user selects a die type and count, taps Roll, and sees the individual results plus a sum when multiple dice are rolled.

## Goals

- Launch quickly and stay out of the way during gameplay.
- Make selecting a die type and rolling as fast as possible (ideally keyboard-friendly).
- Clearly display individual roll values and a total when more than one die is thrown.
- Remain focused: no accounts, no syncing, no tutorials.

## Target Platforms

- **Primary**: macOS 26 (Tahoe) or later.
- **Language/Framework**: Swift + SwiftUI, built with Xcode.
- **Architecture**: Universal binary — Apple Silicon (arm64) and Intel (x86_64). macOS 26 Tahoe supports a subset of Intel Macs, so Intel is included. Uses Xcode's default "Standard Architectures" build setting.

## Features

### Die Selection
- Supported die types: **d2, d4, d6, d8, d10, d12, d20, d100**.
- Selected via a segmented control or similar single-tap picker.
- Default selection: d6.

### Dice Count
- Integer count of dice to roll. Valid range: **1 – 10**.
- Input via a segmented control (one segment per value 1–10) for fast single-click selection.
- Default count: 1.

### Rolling
- A prominent **Roll** button triggers a roll of `count` dice of the selected type.
- Each die is rolled independently using a uniformly distributed random integer in `[1, faces]`.
- Uses `SystemRandomNumberGenerator` (cryptographically secure on Apple platforms) for fairness.
- Keyboard shortcut: **Return** triggers Roll (the Roll button is wired as the window's default action via `.keyboardShortcut(.defaultAction)`).

### Results Display
- Shows the individual roll values for the most recent roll (e.g., `4, 2, 6, 1`).
- With a maximum count of 10, all values fit comfortably on a single line — display as a horizontal row of values using a large, easily-read font.
- If `count > 1`, also shows a **Sum** (e.g., `Sum: 13`) on a line below the individual values.
- If `count == 1`, shows only the single value (no redundant sum).
- Results area shows a placeholder message before the first roll (e.g., "Press Roll to roll dice").

### Persistence
- Selected die type and dice count persist across app launches via `@AppStorage` (backed by `UserDefaults`).
- The most recent roll result is **not** persisted; the results area resets to its placeholder on each launch.

## User Interface

A single fixed-size window (480 × 300 points) containing (top to bottom):

1. **Die Type picker** — segmented control: `d2 | d4 | d6 | d8 | d10 | d12 | d20 | d100`.
2. **Count picker** — segmented control with one segment per value `1`–`10`, default 1.
3. **Roll button** — prominent, default keyboard action.
4. **Results view** — individual rolls and (conditionally) sum.

Window is fixed at 480 × 300 points (not resizable). Uses system-standard fonts and colors (supports light/dark mode automatically).

Closing the window terminates the app (single-window utility, no dock-only background mode).

## Technical Requirements

- **Build**: Xcode project (`.xcodeproj`) with a single app target.
- **Dependencies**: None beyond the Apple SDK. No third-party packages.
- **Persistence**: `@AppStorage` for selected die type and dice count only. No other state is persisted.
- **Sandbox**: App Sandbox enabled, no entitlements beyond the default (no network, no file access).
- **Testing**: Unit tests for the roll engine; SwiftUI previews for the UI.

## Constraints

- Single developer, hobby project; keep complexity minimal.
- Must build cleanly with the latest stable Xcode.
- No analytics, telemetry, crash reporters, or network calls.

## Out of Scope (v1)

- Custom die types (e.g., d7, d30).
- Modifiers (e.g., `2d6 + 3`).
- Roll history or undo.
- Dice rolling animations or sound effects.
- Multi-window support.
- iOS/iPadOS build.
- Localization (English only).
- App Store distribution.
