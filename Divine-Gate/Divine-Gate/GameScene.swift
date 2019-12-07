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
//    var generators : [PanelGenerate];
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    var activePanel:Panel!; // 操作対象にあるパネルを指す
    let len : Int = 5; // 表示するcontainerとgeneratorの数
    var began_location_x :Int = 1;// activePanelの初期x座標. container外でタップが離されたときに元のPanelGenerateに戻すときに使う
    var began_location_y :Int = 1;// activePanelの初期y座標. 同上.
    var startDate : NSDate = NSDate();//開始時間
    var countable = false;//カウントする為のフラグ
    var countjudge = true;//countableの値を変えない為のフラグ
    let labeli = SKLabelNode(fontNamed: "Verdana")//文字を扱うための変数labeli
                                                  //"Verdana"はフォントの名前
    var dateFormatter = DateFormatter();//日付と時刻を表現
    var generators:[PanelGenerate] = [];
    var containers:[PanelContainer] = [];
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        initPanelGenerate();
        initPanelContainer();
        self.labeli.color = UIColor(named: "white");//表示される文字の色?
        self.labeli.fontSize = 100;//文字のサイズ
        self.labeli.zPosition = 100;//文字のZ座標
        self.labeli.fontColor = UIColor.white;//表示される文字の色
        self.labeli.text = "Divine:"; //画面に表示される文字
        self.labeli.position = CGPoint(x: 0, y: 150)//文字の位置を指定
        //self.labeli
        labeli.name = "buttonLabel"

        print(self.labeli);
        self.addChild(labeli);
        print("name of this scene: " + self.name!);
    }
    
    /*
        5つのPanelGenerateインスタンスを用意してSceneに配置
     */
    func initPanelGenerate(){
        //パネル生成のクラス
        for i in 0..<self.len{
            let pg : PanelGenerate = PanelGenerate();
            
            // スクリーンサイズの取得
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height

            
            pg.setpoint(x:-250 + i * 125 ,y : -450);
            self.generators.append(pg);
            pg.generate();
            self.addChild(pg.pal!);
            self.addChild(pg);
        }
    }
    
    /*
        5つのPanelContainerインスタンスを用意してSceneに配置
     */
    func initPanelContainer(){
        for i in 0..<self.len{
            var pc: PanelContainer = PanelContainer();
            pc.position = CGPoint(x: -250 + i * 125 , y : -300);
            self.containers.append(pc);
            self.addChild(pc);
        }
    }
    
    /*
        touchesbeginから呼ばれる
     */
    func touchDown(atPoint pos : CGPoint) {
        let location = pos;
        for i in 0..<self.generators.count{
            if (generators[i].contain(touchX: Int(location.x), touchY: Int(location.y))){
//                            print(generators[i].x, generators[i].y);
                self.activePanel = generators[i].pal;
                self.began_location_x  = Int(self.activePanel.position.x);
                self.began_location_y  = Int(self.activePanel.position.y);
            }
        }
    }
            
    func touchMoved(toPoint pos : CGPoint) {
        if (activePanel != nil){
            let location = pos;
            self.activePanel.setPosition(x: Int(location.x), y: Int(location.y));
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if (activePanel != nil){ // 選択中のpanelが存在する場合
            var interacted_pc_index = getInteractedContainerIndex(pos: pos); // 離した座標から、どのcontainerかを判別。具体的には、self.containersのインデックスを返す。どのcontainerも含まれてなかったと判断したら、-1を返す。
            
            if (interacted_pc_index != -1){ // 1 タップを離した部分の座標がcontainerに含まれる時
                if countjudge{
                    countable = true//カウントするためのフラグを立てる
                    startDate = NSDate();//開始時間
                }
                countjudge = false;
                if self.containers[interacted_pc_index].addPanel(panel: self.activePanel){ // 1.1 containerの容量が空いていたら
                    for i in 0..<len{ //generate処理
                        if( generators[i].pal == self.activePanel){
                            generators[i].destroyPanel();
                            generators[i].generate();
                            self.addChild(generators[i].pal!);
                        }
                    }
                }else{ // 1.2 containerの容量が空いていなかったら(満タンだったら)
                    backToBeginPoint();
                }
            }else{  // 2 containerに含まれない時
                backToBeginPoint();
            }

            self.activePanel = nil;
        }
    }
    
    func getInteractedContainerIndex(pos : CGPoint) -> Int{
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
    
    /*
        container外でactivePanelをタップする指が離されたときに、元の位置に戻す関数.
     */
    func backToBeginPoint(){
        self.activePanel.position = CGPoint(x: self.began_location_x, y: self.began_location_y);
    }
    
    /*
        タップが開始したときに呼ばれる
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{ self.touchDown(atPoint: touch.location(in: self)) }
    }
            
    /*
        タップした状態で動かしたときに呼ばれる
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{ self.touchMoved(toPoint: touch.location(in: self)) }
    }
    
    /*
        タップが終了したとき(シーンから指が離されたとき)に呼ばれる
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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
            var int: Int = Int(time)//intにキャスト
            var str: String = String(int)//strngにキャスト
            labeli.text = str;
            if time > 5.0{
                countable = false;
            }
        }
     //   Called; before; each; frame is rendered
    }
    

}
