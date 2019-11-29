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
//    var frame_panel_list : [PanelGenerate];
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    var activePanel:Panel!;
    let len : Int = 5;
    var began_location_x :Int = 1;//パネルの初期x座標
    var began_location_y :Int = 1;//パネルの初期y座標
    var startDate : NSDate = NSDate();//開始時間
    var countable = false;//カウントする為のフラグ
    var countjudge = true;//countableの値を変えない為のフラグ
    let labeli = SKLabelNode(fontNamed: "Verdana")
    var dateFormatter = DateFormatter();
    
    var frame_panel_list:[PanelGenerate] = [];
    var containers:[PanelContainer] = [];
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        add_list();
        initPanelContainer();
//        self.label.color = UIColor(named: "white");
        self.labeli.fontSize = 100;
        self.labeli.zPosition = 100;
        self.labeli.fontColor = UIColor.white;
        self.labeli.text = "iasd;oihasdlifh:asdjf:";
        self.labeli.position = CGPoint(x: 0, y: 150)
//        self.labeli
        labeli.name = "buttonLabel"

        print(self.labeli);
        self.addChild(labeli);
        print("The Scene was loaded in new scene");
    }
            
    func add_list(){
        for i in 0..<self.len{
            var pg : PanelGenerate = PanelGenerate();
            pg.setpoint(x:-250 + i * 125 ,y : -200);
            self.frame_panel_list.append(pg);
            pg.generate();
            self.addChild(pg.pal!);
            self.addChild(pg);
        }
//        self.panel = self.frame_panel_list[0].pal!;
        
    }
    
    func initPanelContainer(){
        for i in 0..<self.len{
            var pc: PanelContainer = PanelContainer();
            pc.position = CGPoint(x: -250 + i * 125 , y : 100);
            self.containers.append(pc);
            self.addChild(pc);
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
            
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
        if (activePanel != nil){ // 選択中のpanelが存在する場合
            var interact_pc_index = getInteractedContainerIndex(pos: pos);
            
            if (interact_pc_index != -1){ // 1. タップを離した部分の座標がcontainerに含まれる時
                if countjudge{
                    countable = true//カウントするためのフラグを立てる
                    startDate = NSDate();//開始時間
                }
                countjudge = false;
                if self.containers[interact_pc_index].addPanel(panel: self.activePanel){ // 1.1 containerの容量が空いていたら
                    for i in 0..<len{ //generate処理
                        if( frame_panel_list[i].pal == self.activePanel){
                            frame_panel_list[i].destroyPanel();
                            frame_panel_list[i].generate();
                            self.addChild(frame_panel_list[i].pal!);
                        }
                    }
                }else{ // 1.2 containerの容量が空いていなかったら(満タンだったら)
                    backToBeginPoint();
                }
            }else{  // 2. containerに含まれない時
                backToBeginPoint();
            }

            self.activePanel = nil;
        }
    }
            
    func getInteractedContainerIndex(pos : CGPoint) -> Int
    {
        var all_nodes = self.nodes(at: pos);
        var i : Int = -1;
        for node_ in all_nodes{
            for i in 0..<self.containers.count{
                if (containers[i] == node_){
                    return i;
                }
            }
        }
        return i;
    }
    
    func backToBeginPoint(){
        self.activePanel.position = CGPoint(x: self.began_location_x, y: self.began_location_y);
    }
            
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self);
            for i in 0..<self.frame_panel_list.count{
                if (frame_panel_list[i].contain(touchX: Int(location.x), touchY: Int(location.y))){
//                            print(frame_panel_list[i].x, frame_panel_list[i].y);
                    self.activePanel = frame_panel_list[i].pal;
                    self.began_location_x  = Int(self.activePanel.position.x);
                    self.began_location_y  = Int(self.activePanel.position.y);
                }
            }
        }

    }
            
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        if (activePanel != nil){
            for touch in touches{
                let location = touch.location(in: self);
                self.activePanel.setPosition(x: Int(location.x), y: Int(location.y));
            }
        }
    }
            
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
           
         /*
         elseで、パネルを収容した際には、新しいパネルを生成する。
         */
        
    }
            
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
            
            
    override func update(_ currentTime: TimeInterval) {
        if countable{
            dateFormatter.dateFormat = "mm:ss.SS"
            var time = NSDate().timeIntervalSince(self.startDate as Date);//NSDateは現在の時刻
            let targetDate = Date(timeIntervalSinceReferenceDate: time);
            labeli.text = dateFormatter.string(from: targetDate);
//            labeli.text = "hoge";
            if time > 5.0{
                countable = false;
            }
            
            print(time)
        }
            // Called before each frame is rendered
    }
    

}
