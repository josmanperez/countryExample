<!--![Countries]-->

**Countries** is a project to demonstrate the use of several components within iOS framework 

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#using-alamofire)
- [License](#license)

## Features

- [x] Retrieve real data from a server (powered by https://rapidapi.com/)
- [x] Converts JSON data into objects using Codable library.
- [x] Displays data on two differents screens (city list collectionView and a detail view controller).
- [x] Display random picture of Unsplash (https://unsplash.com/) in detail view to ilustrate the country. 
- [x] Uses Apple MapKit to display the location of the property.
- [x] Documentation of classes and methods are located in docs

## Requirements

- iOS 11.0+
- Xcode 10.2+
- Swift 5+

## Installation

Download or clone the project. In order to work with this project you need an **api key** from _rapidapi_ in order to use the web servie. Aditionally if you want to use Unsplash service you also need an Unsplash **api key**. 

### Instrucctions 

- [x] Create a ``` apiKey.plist ``` file
- [x] Paste this struccture on the plist: 

``` 
<plist version="1.0">
<dict>
	<key>unsplash</key>
	<dict>
        <key>url</key>
        <string>https://api.unsplash.com/search/photos</string>
        <key>key</key>
        <string>your_api_key</string>
        <key>per_page</key>
        <string>1</string>
	</dict>
	<key>restapikey</key>
	<string>your_api_key</string>
	<key>restapiurl</key>
	<string>https://restcountries-v1.p.rapidapi.com/all</string>
</dict>
</plist> 
``` 

- [x] Run
```
pod install
```

## Usage

Once starting the app it will retrieve a fixed list of countries and will convert those properties into objects using `Decodable` library. 
If you click on one country it will retrieve detailed information about it and will display it on screen. 
Uses `MapKit` to show the location of the country on a map.
Uses a `CollectionView` to show the list of countries retrieved by the web service.

## License

Open Source example project
