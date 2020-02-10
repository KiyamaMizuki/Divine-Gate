//
//  TitleScene.swift
//  Divine-Gate
//
//  Created by 上間　翔 on 2019/12/19.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit


class TitleScene: SKScene{
    var strat = SKLabelNode();
    var hoge = SKLabelNode();
    override func didMove(to view: SKView) {
        strat.text = "GameStart"
        strat.position = CGPoint(x:200,y:500)
        self.addChild(strat)
    }
    
    func touchDown(movescene : String, atPoint pos : CGPoint) {
        if let node = atPoint(pos) as? SKLabelNode {
            if(node == strat){
                if let view = self.view {
                    if let scene = StageSelect(fileNamed: movescene) {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene)
                    }
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(movescene: "StageSelect", atPoint: t.location(in: self)) }
    }
}
