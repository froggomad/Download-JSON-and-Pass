# Download-JSON-and-Pass

* This Project Demonstrates downloading an HTTP request containing a JSON payload using Alamofire
* The JSON is then mutated and passed to a second view controller using a segue

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



## About the Xcode Project

* The File Structure May be a bit different than you're used to in an Xcode project - that's because the project is built using the MVC (Model/View/Controller) methodology.
* You may also notice the View Controllers aren't responsible for much at all.

### About MVC Methodology:
1. The MVC Methodology strives to separate code, making organization a priority, maintainability easier, and potentially increasing your app's performance.
1. To make things easier, I group files by their intended purpose.
1. Files changing a view (View Controllers) are placed in the Controller group
1. Files changing data or containing global constants are stored in the Model group
1. Custom Views, Storyboards, and XIBs are stored in the View folder
1. Other project files (xcassets, info.plist, appDelegate) are stored in the Supporting Files group



### Project Files and Purposes:

1. Model/Globals.swift
    * Stores Global Constants
    
1. Model/JSON.swift
    * Responsible for modifying JSON - contains the JsonHandler() Class which takes a Dictionary and outputs a JSON String
    * contains the String extension toJSON() which converts a string to JSON
    
1. Network.swift
    * Responsible for making Network Get Requests
    * Would also be responsible for other network requests
    
1. ViewController.swift
    * This is the initial entry point.
    * When the view appears:
        1. the Network() class is instantiated
        1. A get request is made - the payload contains JSON
        1. The payload is sent to a class variable
        1. The payload is modified
        1. A segue is triggered, the payload is the sender
        1. During segue, the sender is assigned to a variable in the Second View Controller
        
1. SecondViewController.swift
    * When the view is loaded:
        1. JSON data that isn't a string is converted to a string
        1. JSON data is displayed on labels

## Creating a second view controller

### Create the File
1. File -> New File
    1. Cocoa Touch Class -> Next
    1. In Class: Name your class (I named mine secondVC because I'm so original)
    1. In SubClass of: Select UIViewController -> Next
    1. Select the group/folder you want it in (If you're using the directory structure I use, it would go in the Controller group) -> Create

### Create the view
1. Go to your Storyboard
    1. Select your ViewController by clicking on the yellow button on its header
    1. If you already have a blank View Controller View, or one without any elements linked to a View Controller File:
        1. cmd+c to copy the ViewController
        1. cmd+v to paste it
    1. If you don't have a blank View Controller, open the Library (where you get labels, etc from) and search for View Controller, then drag that out to the storyboard
    1. Move the VC you just pasted so its a little ways away from the first one, but both are still visible.
    1. Select the VC you just pasted by clicking on the yellow button in its frame
    1. On the right (make sure your right pane is visible in Xcode) select the identity inspector (the box with generic looking text and a view)
    1. In Class: Name your class the same thing you named it when creating the Cocoa Touch Class earlier

## Defining a Segue

1. Select the second view controller by clicking the yellow button on its header
1. Hold ctrl and click-drag from the yellow button to the frame of the second view controller -> release the mouse when the secondVC is highlighted
1. Select Present Modally (this will pop the view over the first view controller)
1. You'll notice a line going from one VC to the other now, click this line
1. In the right pane, in the identity inspector, name the segue something you'll remember

## Passing Data on Segue

1. Swift contains a builtin Method that fires any time a segue is requested - `prepare(for: segue, sender)`. We call it like this:
```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondVC" {
            if let secondVC = segue.destination as? SecondViewController, let json = sender as? [String:Any] {
                secondVC.json = json
            }
        }
    }
```

```swift
if segue.identifier == "secondVC" {
```
* The segue identifier you defined earlier goes here

```swift 
if let secondVC = segue.destination as? SecondViewController,
```
* Here you're defining secondVC as the destination
* SecondViewController is the secondVC's class

```swift
let json = sender as? [String:Any] {
```
* Here you're defining the variable json as the sender, making sure it's a Dictionary of String:Any (the sender is passed when you call the segue, discussed below)
 ```swift
 secondVC.json = json
 ```
 * Here's where the actual data gets passed to the second view controller. json in this context is a member of secondVC which is the second view controller

### Triggering a segue
```swift
self.performSegue(withIdentifier: "secondVC", sender: self.json)
```
* withIdentifier is the segue's identifier defined earlier. sender is the data you want to pass (unwrapped in ```prepare(for: segue, sender)```)
