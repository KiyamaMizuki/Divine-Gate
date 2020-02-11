//
//  DungeonSelectScene.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit

class DungeonSelectScene : SKScene{
    var button_num : Int = 2;
    var buttons : [Button] = [];
    override func didMove(to view: SKView) {
        self.name = "dungeon_select";
        initButtons();
    }
    
    func initButtons(){
        for i in 0..<button_num{
            var name = "button";
            name += String(i);
            print(name)
            var button = self.childNode(withName: name) as! Button;
            button.isUserInteractionEnabled = true;
            button.setTouchUp {
                let scene = Search(fileNamed: "Search");
                scene?.scaleMode = .aspectFill
                scene!.former_screen = self.name!
                scene?.dungeon_id = button.id;
                self.view!.presentScene(scene)

            }
            button.id = i;
        }
    }
}

