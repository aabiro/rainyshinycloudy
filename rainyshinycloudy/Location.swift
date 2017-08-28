//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Maureen Biro on 2017-05-18.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//


//singleton class
import Foundation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
    
}
