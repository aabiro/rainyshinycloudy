//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Aaryn Biro on 2017-05-17.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>){
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject>{
            if let min = temp["temp_min"] as? Double {
                
                    let kelvinToCelcius = Double(round(min - 273.15))
                
                let strLow = "\(kelvinToCelcius)\"°"  //20.0"°

                
                self._lowTemp = strLow.replacingOccurrences(of: "\"", with: "")


            }
            
            if let max = temp["temp_max"] as? Double {
                
                let kelvinToCelcius = Double(round(max - 273.15))
                
                
                let str = "\(kelvinToCelcius)\"°"  //20.0"°

                self._highTemp = str.replacingOccurrences(of: "\"", with: "")
                

                
            }
            
            
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    
}

extension Date {
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
}
