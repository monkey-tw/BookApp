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
- Navigation based on UIKit, because UIKit can help us to implement some complex features what SwiftUI can't do.
- Page view UI based on SwiftUI.SwiftUI can help us to implement simple UI productivity.
- Modularized based on CocoaPods.
- Code quality based on SwiftLint.
- Unit test based on XCTest.

# Connect to AWS server
The book APP is configured to connect with AWS server by default.

# Connect to local server
- Refer to [BookServer](https://github.com/monkey-tw/BookServer.git) to run backend project based on Docker, then you can test iOS project with local server.
- Then go to Settings page in APP, you can change the base url channel to localhost.