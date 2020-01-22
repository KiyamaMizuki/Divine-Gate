//
//  Search.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2020/01/17.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class Search: SKScene {
    
    var activePanel:SearchPanel!;
    var containers:[SearchPanelContainer] = [];//パネル収容ボックスのリスト
    var countjudge = true;//countableの値を変えない為のフラグ
    var startDate : NSDate = NSDate();//開始時間
    var countable = false;//カウントする為のフラグ
    var began_location_x :Int = 1;
    var began_location_y :Int = 1;
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        initPanelGenerate();
    }
    
    let len : Int = 5; // 表示するcontainerとgeneratorの数
    var generators:[SearchPanelGenerate] = [];//パネル生成ボックスのリスト
    
    func initPanelGenerate(){
        //パネル生成のクラス
        for i in 0..<self.len{
            let pg : SearchPanelGenerate = SearchPanelGenerate();

            
            pg.setpoint(x:-250 + i * 125 ,y : -450);//パネル生成の箱の位置
            self.generators.append(pg);
            pg.generate();
            self.addChild(pg.pal!);
            self.addChild(pg);
        }
    }
    
    func initPanelContainer(){
        for i in 0..<self.len{
            var pc: SearchPanelContainer = SearchPanelContainer();
            pc.position = CGPoint(x: -250 + i * 125 , y : -300);//パネルコンテナボックスの位置
            self.containers.append(pc);
            self.addChild(pc);
            
        }
    }
    
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
                        countable = true//カウントするためのフラグを立てる。また５秒経ったらfalseになる
                        startDate = NSDate();//開始時間
                    }
                    countjudge = false;
                    if self.containers[interacted_pc_index].addPanel(panel: self.activePanel,judgeflag : countable)&&countable{ // 1.1 containerの容量が空いていたら
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
    //                print("実行すスキルは?");
    //                print(self.u.getexecutable(container: containers[interacted_pc_index])[0].name);
                    
                    
                }else{  // 2 containerに含まれない時
                    backToBeginPoint();
                }

                self.activePanel = nil;
            }
        }
    
    func backToBeginPoint(){
        self.activePanel.position = CGPoint(x: self.began_location_x, y: self.began_location_y);
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
}
