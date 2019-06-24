# Download-JSON-and-Pass

This Project Demonstrates downloading an HTTP request containing a JSON payload using Alamofire
The JSON is then mutated and passed to a second view controller using a segue

## Pre-Requisites

1. The project includes the Alamofire pod. Before being able to run the project, you must install the Alamofire pod:

    1. Open terminal and type: `sudo gem install cocoapods` (Gem will get installed in Ruby inside System library. Or try on 10.11 Mac OSX El Capitan, type: `sudo gem install -n /usr/local/bin cocoapods`)
        1. If there is an error "activesupport requires Ruby version >= 2.xx", then install latest activesupport first by typing in terminal `sudo gem install activesupport -v 4.2.6`

    1. After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done. Next, you need to setup the cocoapods master repo. Type in terminal: 
    1. `pod setup` And wait. It will download the master repo. The size is very big (370.0MB at Dec 2016). So it can be a while. You can track of the download by opening Activity and goto Network tab and search for git-remote-https.
    1. Once done it will output "Setup Complete"
    
    ### If you already have cocoapods installed on your machine:
    1. In terminal cd to your XCode project root directory (where your .xcodeproj file resides) and type:
    1. `pod init`
    1. Then open your project's podfile by typing in terminal:
    1. open -a Xcode Podfile
    1. Your Podfile will open in text mode. Initially there will be some default commands in there. Here is where you add your project's dependencies. For example, in the podfile, type
    1. `pod 'Alamofire'`
    1. Uncomment  platform :ios, '9.0' 
    1. Uncomment  use_frameworks! (it may already be uncommented)
    1. When you are done editing the podfile, save it and close Xcode. (You can leave Xcode open, but the project will be unusable in that state)
    1. Then install pods into your project by typing in terminal:
    1. `pod install`
    
    ###Now when you open your project, do NOT open the xcodeproj file - it will just crash when you try to run the project.
    1. Open the .xcworkspace file instead. This is your new Xcode project

## About the Project

* The File Structure May be a bit different than you're used to in an Xcode project - that's because the project is built using the MVC (Model/View/Controller) methodology.

### About MVC Methodology:
1. The MVC Methodology strives to separate code, making organization a priority, maintainability easier, and potentially increasing your app's performance.
1. To make things easier, I group files by their intended purpose.
1. Files changing a view are placed in the Controller group
1. Files changing data or containing global constants are stored in the Model group
1. Custom Views, Storyboards, and XIBs are stored in the View folder
1. Other project files (xcassets, info.plist, appDelegate) are stored in the Supporting Files group
