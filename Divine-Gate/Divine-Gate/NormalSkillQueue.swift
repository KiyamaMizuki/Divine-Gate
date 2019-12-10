//
//  NormalSkillQueue.swift
//  Divine-Gate
//
//  Created by 上間　翔 on 2019/12/10.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
class NormalSkillQueue:  SKSpriteNode{
    var skillqueue : [NormalSkill]  = []
    
    
    
    func insert(inserted_skill : NormalSkill){
        self.skillqueue.append(inserted_skill)
    }
    
    func pop() -> NormalSkill?{
        var ns : NormalSkill? = nil;
        if self.skillqueue.count >= 1 {
            ns = self.skillqueue[0];
            self.skillqueue.removeFirst();
        }
        return ns;
    }
}
