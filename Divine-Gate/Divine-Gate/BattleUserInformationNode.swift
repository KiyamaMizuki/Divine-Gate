//
//  BattleUserInformationNode.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/01/12.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class BattleUserInformationNode : SKNode{
    
    var x : Int = 0;
    var y : Int = 0;
    var width : Int = 0;
    var height : Int = 0;
    var corner_x : Int = 0;
    var corner_y : Int = 0;
    var units_hpsum : Hpsum!
    var dvunits : [BattleUnit] = [];
    var spcount : Int = 20;
    
//    override init(){
//        super.init()
//    }
    
    func setPosition(x: Int, y:Int){
        self.x = x;
        self.y = y;
        self.position = CGPoint(x: x, y: y);
        self.corner_x = self.x - self.width / 2
        self.corner_y = self.y - self.height / 2
    }
    
    func setSize(width : Int, height : Int){
        self.width = width;
        self.height = height;
    }
    
    func setImageToChildren(node_lis : [BattleUnit]){
        for i in 0..<node_lis.count{
            let node_name = "Unit" + String(i + 1);
            var unit_node = (childNode(withName: node_name) as? BattleUnit?)!!
            node_lis[i].size = unit_node.size
            node_lis[i].position = unit_node.position
            node_lis[i].isUserInteractionEnabled = true;
            node_lis[i].texture = SKTexture(imageNamed: node_lis[i].image_path);
            self.addChild(node_lis[i]);
            self.dvunits.append(unit_node);
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}
