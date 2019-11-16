//
//  GameScene.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    var panel:Panel!;
    var panelcon:PanelContainer!;
    //SKSpriteNodeを定義
    private var targetNode : SKSpriteNode?
    
        override func didMove(to view: SKView) {
            
    //        let hoge:SKSpriteNode! = SKSpriteNode(imageNamed: "red_panel");
    //        hoge.xScale = 0.1;
    //        hoge.yScale = 0.3
    //        hoge.position = CGPoint(x: 10, y:10);
    //        addChild(hoge);
            
            
            
            self.panelcon = PanelContainer();
            
            self.panel = Panel(type: "wind");
            print(self.panel);
            self.addChild(self.panel);
            self.addChild(self.panelcon);
                print("The Scene was loaded in new scene");
            }
            
    
            func touchDown(atPoint pos : CGPoint) {
            //中身はからに
            }
            
           
    
            func touchMoved(toPoint pos : CGPoint) {
                   //今触れている相手を全て取得
                   let array = self.nodes(at: pos)
                
               
                   //意中の相手だったら赤く染まる
                   for target in array{
                    print(target);
                    print(self.panel);
                       if target == self.panel {
                        self.panel.texture = SKTexture(imageNamed: "Box");
                       }
                   }
               }
            
            func touchUp(atPoint pos : CGPoint) {
            //中身は空に
            }
            
    
    
    
    
            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
        //        if let label = self.label {
        //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //        }
        //
        //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
                
//                for touch in touches{
//                    let location = touch.location(in: self);
//                    self.panel.position = CGPoint(x: 15, y: 15);
//                    
//                    
//                    
//                }
            }
            
            override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
                for touch in touches{
                    let location = touch.location(in: self);
                    self.panel.setPosition(x: Int(location.x), y: Int(location.y));
                    
                }
                
            }
            
    
            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if target == 
                                  
        //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
                
            }
            
    
            override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
            }
            
            
            override func update(_ currentTime: TimeInterval) {
                // Called before each frame is rendered
            }
    //
    //    func dragInterraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview?{
    //
    //        guard let panel = self.panel else return nil;
    //        return UITargetedDragPreview(view: panel);
    //    }
    //
    //    func

}
