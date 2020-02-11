//
//  ClickableSpriteNode.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit


class ClickableSpriteNode : SKSpriteNode{
    
    var callback_onclick : () -> Void = { print("clicked"); };
    var callback_onMove : () ->  Void = {print("movede");};
    var callback_onTouchUp : () -> Void = {print("touchup")};

    
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color : color, size : size);
//        self.setClick {
//            print("clicked");
//        }
//        self.setMove {
//            print("moved");
//        }
//        self.setTouchUp {
//            print("touchup");
//        }
//        self.isUserInteractionEnabled = true;
//        
////        self.texture = texture;
////        self.color = color;
////        self.size = size;
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size);
//        self.isUserInteractionEnabled = true;
//    }
//    init(){
//        super.init(texture: SKTexture(imageNamed: "blu"), color: UIColor.red, size: CGSize(width: 10, height: 10));
//        self.isUserInteractionEnabled = true;
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//    }
    
    func setClick(callback : @escaping () -> Void){
        self.callback_onclick = callback;
    }
    
    func setMove(callback: @escaping () -> Void){
        self.callback_onMove = callback;
    }
    
    func setTouchUp(callback: @escaping () -> Void){
        self.callback_onTouchUp = callback;
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            callback_onclick();
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            callback_onMove();
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            callback_onTouchUp();
        }
    }
    
    
    
    
    
    
    
    
    
}
