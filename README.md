![logo](/Demo/logo.png)

# Kolorofon

*Simple game where you follow your favorite color. How funny is that?*

![platform](https://img.shields.io/badge/platform-iOS-green.svg)
![swift](https://img.shields.io/badge/swift-5.0-orange.svg)
![xcode](https://img.shields.io/badge/xcode-11.3.1-blue.svg)
[![Build Status](https://travis-ci.org/vandermesis/ColorPatterns.svg?branch=master)](https://travis-ci.org/vandermesis/ColorPatterns)

## How it looks like
![animation](/Demo/animation.gif)

## What is it

It's for me to practise coding. I started to write code to that game from a very first lesson of Swift.
I would like to this game would grow with me as I learn to code. We will see where it lead us :)

- [x] used MVVM software architecture 
- [x] followed coding best practices and SOLID principles
- [x] used Gitflow
- [x] all critical parts of application covered by unit tests with use of Travis CI

## How to use it

- Follow your colour! 
- You have 90 seconds. 
- Pick your favorite color and remember it. 
- After colors change tap your chosen color to get a point.
- If your chosen color is not on the screen, swipe down to shuffle colors.
- If you tap wrong color you lose a point.
- to exit game before time ends simple swipe up

Levels:
- Easy - 12 colors
- Medium - 36 colors
- Hard - 72 colors

Points count depends on winning streak:
- 4 winning streak and below - 1 point
- 5 winning streak - 2 points
- 10 winning streak - 3 points
- 20 winning streak - 4 points
- 30 winning streak - 5 points
- 40 winning streak - 6 points
- 50 winning streak - 7 points
- 60 winning streak - 8 points
- 70 winning streak - 9 points
- 80 winning streak and above - 10 points

Simple as that!
Ho!



## What new I've learned

- Settings.bundle
- MVC design pattern
- MVVM design pattern
- SOLID
- Timer class
- UISwipeGestureRecognizer for swipe down and shake
- Observed properties
- Giflow
- Danger with Swiftlint
- Game Center
- Notification Center

## To-do

- [x] Add logic to shuffle colors and remember user's choice
- [x] Use Travis CI
- [x] Use MVVM design pattern
- [x] Add Game Over screen with user score
- [x] Make welcome screen with start game and difficulty levels
- [x] Add animation to Start Menu
- [x] Connect with Apple Game Center
- [x] Save user scores to Game Center leaderboards
- [x] Separate leaderboards for each difficulty level
- [x] Add difficulty levels (more/less colors to choose from, different range of colors error)
- [x] Tailor UI and UX
- [x] Unit Tests
- [x] Change default sounds
- [x] Manage app didEnterBackground cases
- [x] Change user points calculation model to add extra points for winning streak
- [ ] Add endless difficulty mode to play without timer

## What is needed

- Xcode 11.3.1 with iOS SDK (12.2)
- Bundler
- CocoaPods

## What was really helpful

- *[Bundler](https://github.com/bundler/bundler)* - makes sure Ruby applications run the same code on every machine
- *[Cocoapods](https://cocoapods.org)* - cocoa dependency manager
- *[SwiftLint](https://github.com/realm/SwiftLint)* - enforce Swift style and conventions
- *[R.swift](https://github.com/mac-cain13/R.swift)* - strong typed, autocompleted resources
- *[Quick](https://github.com/Quick/Quick)* - behavior-driven development framework for Swift and Objective-C
- *[Nimble](https://github.com/Quick/Nimble)* - express the expected outcomes of Swift or Objective-C expressions
- *[JetBrains](https://www.jetbrains.com/lp/mono/)* - a typeface for developers

## Who is who

Marek Skrzelowski, mskrzelowski@vandermesis.com

*.swift learning month one*
