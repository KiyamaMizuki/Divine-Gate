  
//
//  NormalSkillQueue.swift
//  Divine-Gate
//
//  Created by 上間　翔 on 2019/12/10.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//
import Foundation
import SpriteKit
class NormalSkillQueue:  SKSpriteNode{ // 灰色のnormalSkillQueueを表示する
    var skillqueue : [SkillView]  = [];
    let screenwidth = UIScreen.main.bounds.size.width//スマホの横幅
    var x: Int = 0;
    var y: Int = 0;
    var width: Int = 0;
    var height: Int = 0;
    
    func insert(inserted_skill_view : SkillView){ // skillviewのinsertを担う
        var hoge = self.y - Int(Float((self.size.height / 2 ))) + inserted_skill_view.height
        var skill_y = hoge + inserted_skill_view.height * self.skillqueue.count;
        self.skillqueue.append(inserted_skill_view)
        inserted_skill_view.setPosition(x: 0, y: skill_y);
        inserted_skill_view.size.width = self.size.width - 20
        inserted_skill_view.zPosition = self.zPosition + 1;
        self.addChild(inserted_skill_view);
    }
    
    func delete(){
        self.removeAllChildren();
        self.skillqueue.removeAll();
    }
    

    
    func pop() -> SkillView?{
        var ns : SkillView? = nil;
        if self.skillqueue.count >= 1 {
            ns = self.skillqueue[0];
            ns?.removeFromParent();
            self.skillqueue.removeFirst();
        }
        return ns;
    }
    
    func setpoint(x:Int, y:Int) {
            self.x = x;
            self.y = y;
    //        let z : Int = -10
            self.position = CGPoint(x: self.x, y: self.y);
    //        self.zPosition = CGFloat(z);
            
    }
    
    
}
