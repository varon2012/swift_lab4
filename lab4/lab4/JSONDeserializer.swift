//
//  JSONDeserializer.swift
//  lab3
//
//  Created by Oleg Pyatko on 4/19/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONSerializer{
    func deserialize(source : String) -> WheatherModel{
        let model = WheatherModel();
        if let dataFromString = source.data(using: .utf8, allowLossyConversion: false){
            let json = JSON(data : dataFromString);
            model.temp = json["current"]["temp_c"].doubleValue;
            model.city = json["location"]["name"].stringValue;
            model.latitude = json["location"]["lat"].doubleValue;
            model.longitude = json["location"]["lon"].doubleValue;

        }
        return model;
    }
    
    func deserializeArrayOfCities(source : String) -> [WheatherModel]{
        var cities = [WheatherModel]();
        
        if let dataFromString = source.data(using: .utf8, allowLossyConversion: false){
            let json = JSON(data : dataFromString);
            //let citiesJson = json.array;
            for (_, city) in json {
                let wheatherCity = WheatherModel();
                wheatherCity.city = city["city"].stringValue;
                wheatherCity.latitude = city["latitude"].doubleValue;
                wheatherCity.longitude = city["longitude"].doubleValue;
                cities += [wheatherCity];
            }
        }
        
        return cities;
    }
}
