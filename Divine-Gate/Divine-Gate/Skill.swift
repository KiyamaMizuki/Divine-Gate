//
//  Skill.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import RealmSwift

class Skill : Object, Codable{
    @objc dynamic var name : String
    @objc dynamic var description_c : String
    @objc dynamic var type : String
    var belong : DVUnit?
    
//    init(name : String, description_c : String, type : String) {
//        self.name = name;
//        self.description_c = description_c
//        self.type = type;
//    }
    
    
}
