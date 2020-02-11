//
//  GameOverScene.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/12.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import SpriteKit

class GameOverScene : SKScene{
    
    
    override func didMove(to view: SKView) {
        print("gameover");
        
        var restartButton = self.childNode(withName: "RestartButton") as! Button
        restartButton.isUserInteractionEnabled = true;
        restartButton.setClick {
            let scene = DungeonSelectScene(fileNamed: "DungeonSelectScene");
            scene?.scaleMode = .aspectFill;
            self.view!.presentScene(scene);
        }
        
    }
}
