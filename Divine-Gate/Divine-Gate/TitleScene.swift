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
    var start = SKLabelNode();
    override func didMove(to view: SKView) {
        self.start = self.childNode(withName: "Start") as! SKLabelNode
    }
    
    func touchDown( atPoint pos : CGPoint) {
        if let node = atPoint(pos) as? SKLabelNode {
            if(node == start){
                if let view = self.view {
                    if let scene = DungeonSelectScene(fileNamed: "DungeonSelectScene") {
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
        for t in touches { self.touchDown( atPoint: t.location(in: self)) }
    }
}
