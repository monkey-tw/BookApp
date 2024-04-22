# Prerequisites
- Xcode 15.0+
- Installed Homebrew
- Install CocoaPods via Homebrew: `brew install cocoapods`

# Github
Clone iOS project via: `git clone https://github.com/monkey-tw/BookApp.git`

# Run iOS project
- Open terminal and run: `cd BookApp`
- Run: `pod install`. If there is any error, just go to the next step.
- Open `BookApp.xcworkspace`
- Click `Command+R` shortcut to run the project

# Achitecture
- MVVM + Clean Architecture based on Combine.
- Navigation based on UIKit, page view UI based on SwiftUI.
- Modularized based on CocoaPods.

# Test BookApp
Refer to [BookServer](https://github.com/monkey-tw/BookApp.git) to run backend project, then you can test iOS project.