//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Aaryn Biro on 2017-05-17.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude!)"

let APP_ID = "&appid="
let API_KEY = "f9f713affd1f09e5c263707bd8cd3d70"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"


//not working
let FORECAST_URL =  "http://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f9f713affd1f09e5c263707bd8cd3d70"

