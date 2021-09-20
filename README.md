# Events Arena
A simple event application showing different event category types and a list of events for each type. When any event is clicked, it opens a screen with more details about the event.

## Base Tooling
- `Kingfisher` for downloading and caching images from the web.
- `RealmSwift` for data offline caching.
- `ReachabilitySwift` for checking internet connectivity. 

## Getting Started

### Prerequisites
This project uses cocoapods for dependencies management. If you don't have cocoapods installed in your machine, or are using older version of cocoapods, you can install it in terminal by running command ```sudo gem install cocoapods```. For more information go to https://cocoapods.org/

### Installation

1. Clone this repository to your machine in Xcode or using your machine's Terminal whatever you prefer.\
`git clone https://github.com/nadakamel/events-arena.git`

2. Download CocoaPods on your machine if you don't already have it\
`sudo gem install cocoapods`

3. Install third-party libraries using `pod`\
`pod install`

### Usage
Open  ```Events Arena.xcworkspace``` and run the project.

## Architecture

Model-View-Presenter (MVP) architecture

MVP is an architecture pattern that separates objects into three distinct types mainly made up of Models, Views and Presenter. It was invented to facilitate unit testing and to improve separation of concerns in presentation logic.
Each of the components in MVP play an important role:
- Model holds application data.
- View delegate user interaction to presenter.
- Presenter retrieves data and format it for display in View.

The presenter has no dependences to UIKit and there is a reference between View and Presenter where they both know about each other existence. 


## Screenshots
<img src="https://github.com/nadakamel/events-arena/blob/master/Screenshots/SplashScreen.png" width="300" height="649"> <img src="https://github.com/nadakamel/events-arena/blob/master/Screenshots/EventsListing.png" width="300" height="649"> 

Display details of an event

<img src="https://github.com/nadakamel/events-arena/blob/master/Screenshots/EventDetails.png" width="300" height="649">


