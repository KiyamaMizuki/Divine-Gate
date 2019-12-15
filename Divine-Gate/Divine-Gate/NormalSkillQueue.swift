  
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
    var x: Int;
    var y: Int;
    var width: Int;
    var height: Int;
    
    func insert(inserted_skill_view : SkillView){ // skillviewのinsertを担う
        self.skillqueue.append(inserted_skill_view)
        var skill_y = (self.y - (self.height / 2)) + inserted_skill_view.height * self.skillqueue.count;
        inserted_skill_view.setPosition(x: 0, y: skill_y);
        inserted_skill_view.zPosition = self.zPosition + 1;
        self.addChild(inserted_skill_view);
    }
    
    func delete(){
        self.removeAllChildren();
    }
    
    func draw(){ // 自分の子要素に
        
    }
    
    init(){
        var size :Int = Int(screenwidth)
           self.x = 15;
           self.y = 15;
           self.width = size/5;//パネルの横タップ判定
           self.height = size/5;//パネルの縦タップ判定

           super.init(texture: SKTexture(imageNamed: "frame_panel"), color: UIColor.clear, size: CGSize(width: 100, height: 100));//ジェネレータの情報
           self.position = CGPoint(x: 15, y: 15);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pop() -> SkillView?{
        var ns : SkillView? = nil;
        if self.skillqueue.count >= 1 {
            ns = self.skillqueue[0];
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
