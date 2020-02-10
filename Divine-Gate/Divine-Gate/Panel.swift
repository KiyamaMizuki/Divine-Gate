//
//  Panel.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit

class Panel: SKSpriteNode {
//    init(imageNamed: String){
//        super.init(imageNamed: imageNamed);        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    var gameScene: SKScene!
    var type: String!
    var image_path: String!
    
    var onContainer = false;
    
    func setScene(scene: SKScene){
        self.gameScene = scene
    }
    
    func setType(){
        // fire water wind light dark
        switch self.type{
        case "fire":
            self.image_path = "red_panel";
        case "water":
            self.image_path = "blue_panel";
        case "wind":
            self.image_path = "green_panel";
        case "dark":
            self.image_path = "purple_panel";
        case "light":
            self.image_path = "yellow_panel";
        case .none:
            print("none");
        case .some(_):
            print("some");
        }
    }
    
    init(type : String,panelwidth : Int,panelheight : Int){
        
        super.init(texture: SKTexture(imageNamed: "blue_panel"), color: UIColor.clear, size: CGSize(width: panelwidth, height: panelheight));
        self.position = CGPoint(x: 15, y: 15)//生成した後座標を変更している
        self.type = type;
        self.setType();
        self.texture = SKTexture(imageNamed: self.image_path)
//        self.isUserInteractionEnabled = true;
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in  touches{
////            self.setPosition(x: Int(t.location(in: self).x), y:Int(t.location(in: self).y));
//            self.position = CGPoint(x: t.location(in: parent!).x, y: t.location(in:parent!).y);
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        
//        
//    }
    
//    func touchUp(pos : CGPoint){
//        if isOnNode(nodename: "PanelContainer"){
//            onContainer = true;
//        }else{
//            onContainer = false;
//        }
//    }
    
//    func getUnderNode() -> [SKNode]{ // 下のノードの配列を取得する
//        let pos = self.position
//        let under_nodes = nodes(at: pos);
//        return under_nodes
//    }
//
//    func isOnNode(nodename : String) -> Bool{ //
//        let under_nodes = getUnderNode()
//        for under_node in under_nodes{
//            let name = String(describing: Swift.type(of: under_node))
//            if nodename == name{
//                return true;
//            }
//        }
//        return false;
//    }
    
    func setPosition(x: Int, y: Int){
        self.position = CGPoint(x: x, y: y);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
