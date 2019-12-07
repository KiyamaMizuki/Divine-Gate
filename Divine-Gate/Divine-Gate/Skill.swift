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

class Skill {
    let name : String;
    let description : String;
    let type : String;
    var belong : Unit;
    
    init(name : String, description : String, type : String, belong : Unit) {
        self.name = name;
        self.description = description
        self.type = type;
        self.belong = belong;
    }
    
    
    
}
