//
//  GameJSONSerializer.swift
//  Lab2
//
//  Created by Oleg Pyatko on 3/22/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import Foundation
import SwiftyJSON

class GameJSONSerializer {
    func Deserialize(source : String) -> [GameModel]{
        if let dataFromString = source.data(using: .utf8, allowLossyConversion: false){
            let json = JSON(data : dataFromString);
            var array = [GameModel]();
            for game in json["games"].arrayValue {
                let title = game["title"].stringValue;
                let shortDescription = game["shortDescription"].stringValue;
                let fullDesc = game["fullDescription"].stringValue;
                let imageSource = game["image"].stringValue;
                let gameModel = GameModel(title: title, shortDescription : shortDescription, fullDescription : fullDesc, image : UIImage(named : imageSource));
                array += [gameModel];
            }
            return array;
        }
        return [GameModel]();
    }
}

class WeatherDeserializer{
    func Deserialize(source : String) -> String{
        if let dataFromString = source.data(using: .utf8, allowLossyConversion: false){
            let json = JSON(data : dataFromString);
            let temp = json["current"]["temp_c"].doubleValue;
            return String(temp);
            //let temperature = temp["temp"];
        }
        return "0";
    }
}
