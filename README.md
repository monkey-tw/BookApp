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

# Connect to AWS server
The book APP is configed to connect with AWS server by default, so you access the server directly in APP.

# Build local server
- Refer to [BookServer](https://github.com/monkey-tw/BookApp.git) to run backend project based on Docker, then you can test iOS project.
- Then go to Settings page in APP, you can change the base url channel to localhost.