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
    
//    enum CodingKeys: String, CodingKey{
//            case fire
//            case water
//            case wind
//            case dark
//            case light
//    }
//
//    required init(from decoder: Decoder) throws {
////        fatalError("init(from:) has not been implemented")
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.fire = try container.decode(Int.self, forKey: .fire)
//        self.water = try container.decode(Int.self, forKey: .water)
//        self.wind = try container.decode(Int.self, forKey: .wind)
//        self.dark = try container.decode(Int.self, forKey: .dark)
//        self.light = try container.decode(Int.self, forKey: .light)
//    }
//    required init(){
//
//    }
    
    
    
//    override required init() {
//        fatalError("init() has not been implemented")
//    }
    
    func getAsDict() -> [String : Int]{
        return ["fire":self.fire, "water":self.water, "wind":self.wind, "dark":self.dark, "light":self.light]
    }
}
