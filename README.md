# Prerequisites
- Xcode 15.0+
- Installed Homebrew
- Installe CocoaPods via Homebrew: `brew install cocoapods`
- Java 17+

# Github
Clone iOS project via: `git clone https://github.com/monkey-tw/BookApp.git`
Clone Backend project via: `git clone https://github.com/monkey-tw/BookServer.git`

# Run iOS project
- Open terminal and run: `cd BookApp`
- Run: `pod install`
- Open `BookApp.xcworkspace`
- Click `Command+R` shortcut to run the project

# Run Backend project via IntelliJ IDEA
- Open terminal and run: `cd BookServer`
- Run: `./BuildAndRun.sh`
- Run: `chmod +x BuildAndRun.sh` if you get permission denied error

# Run Backend project via IntelliJ IDEA
- In case there are some error in `Run Backend project via IntelliJ IDEA` stage, you can try this.
- Open BookServer project via IntelliJ IDEA
- Click `Run` button in the top menu, then click `Run 'BookServerApplication'`

# Test BookApp
- After you run Backend project, you can test BookApp via iOS simulator
