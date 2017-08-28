//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Aaryn Biro on 2017-05-17.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//

import UIKit
import Alamofire


//data cconstant current weather class

class CurrentWeather {
    //data encpsulation- best practice
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
        
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = "0.0"
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        //must bypass security https in info.plist
        //initialize url to tell alamofire where to download from
        
    
      //  let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            //print(result)
            print(response)
            //see data coming in^^
            
            //create dictionary 
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized //first letter capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                //inside of original dictionary
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let currentTemp = main["temp"] as? Double {
                        
                        let kelvinToCelcius = Double(round(currentTemp - 273.15))
                        
                        let strCurrent = "\(kelvinToCelcius)\"°"
          
                        

                        self._currentTemp = strCurrent.replacingOccurrences(of: "\"", with: "")
                        print(self._currentTemp)
                        
                    }
                }
                
                
            }
            //need to tell it when to finish
            completed()
            
            }
    
    }
    
    
    
}



