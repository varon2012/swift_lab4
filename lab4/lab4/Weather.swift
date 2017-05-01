//
//  Weather.swift
//  Lab2
//
//  Created by Oleg Pyatko on 4/5/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import Foundation

class Weather {
    var city : String;
    var temp : String = "";
    var url : URL;
    
    init(city : String){
        self.city = city;
        let request = "https://api.apixu.com/v1/current.json?key=152f26ba579c4fb5ba3204721170504&q=" + city;
        url = URL(string: request)!;
    }
}
