//
//  RequirePanelModel.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/01/12.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import RealmSwift
import SpriteKit
import UIKit

class RequirePanelModel : Object, Codable{
    @objc dynamic var fire : Int = 0;
    @objc dynamic var water : Int = 0;
    @objc dynamic var wind : Int = 0;
    @objc dynamic var dark : Int = 0;
    @objc dynamic var light : Int = 0;

    func getNumType(type:String) -> Int{
        switch type {
        case "fire":
            return self.fire
        case "water":
            return self.water
        case "wind":
            return self.wind
        case "dark":
            return self.dark
        case "light":
            return self.light
        default:
            return 1000000
        }
    }
    
    func getAsDict() -> [String : Int]{
        return ["fire":self.fire, "water":self.water, "wind":self.wind, "dark":self.dark, "light":self.light]
    }
}
