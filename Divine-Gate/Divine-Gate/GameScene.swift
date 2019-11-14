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
        override func didMove(to view: SKView) {
            
    //        let hoge:SKSpriteNode! = SKSpriteNode(imageNamed: "red_panel");
    //        hoge.xScale = 0.1;
    //        hoge.yScale = 0.3
    //        hoge.position = CGPoint(x: 10, y:10);
    //        addChild(hoge);
            
            self.panel = Panel(type: "wind");
            print(self.panel);
            self.addChild(self.panel);
                
        //        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }
        //
        //        // Create shape node to use during mouse interaction
        //        let w = (self.size.width + self.size.height) * 0.05
        //        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        //
        //        if let spinnyNode = self.spinnyNode {
        //            spinnyNode.lineWidth = 2.5
        //
        //            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        //            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
        //                                              SKAction.fadeOut(withDuration: 0.5),
        //                                              SKAction.removeFromParent()]))
        //        }
            
                print("The Scene was loaded in new scene");
            }
            
            
            func touchDown(atPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.green
        //            self.addChild(n)
        //        }
                
            }
            
            func touchMoved(toPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.blue
        //            self.addChild(n)
        //        }
            }
            
            func touchUp(atPoint pos : CGPoint) {
        //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        //            n.position = pos
        //            n.strokeColor = SKColor.red
        //            self.addChild(n)
        //        }
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
        //        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
                for touch in touches{
                    let location = touch.location(in: self);
                    self.panel.setPosition(x: Int(location.x), y: Int(location.y));
                }
            }
            
            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
