//
//  GameModel.swift
//  Lab2
//
//  Created by Oleg Pyatko on 3/21/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import Foundation
import UIKit

class GameModel
{
    init(title : String, shortDescription : String, fullDescription : String, image : UIImage?)
    {
        Title = title;
        ShortDescription = shortDescription;
        FullDescription = fullDescription;
        Image = image;
    }
    
    public var Title : String;
    public var ShortDescription : String;
    public var FullDescription : String;
    public var Image : UIImage?;
}
