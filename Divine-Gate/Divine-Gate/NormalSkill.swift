//
//  NormalSkill.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/12/07.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class NormalSkill : Skill{
    var requirePanels : Dictionary<String, Int> = [:];
    var ratio : Float = 0.0;
    var toSingle : Bool = false;
    var executable : Bool = false;
    var skillType : String = "";
    
    
    init(requirePanels : Dictionary<String, Int>, ratio : Float, toSingle : Bool, skillType : String, name : String, description : String, type : String, belong : Unit) {
        super.init(name : name, description : description, type : type, belong : belong);
        self.requirePanels = requirePanels;
        self.ratio = ratio;
        self.toSingle = toSingle;
        self.executable = false;
        self.skillType = skillType;
    }
    
    func judgeExecutable(container : PanelContainer) -> Bool{
        var count_fill :Int =  0
//        for container.
    }
    
    
}


