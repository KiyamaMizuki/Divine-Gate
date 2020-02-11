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
import RealmSwift

class Search: SKScene {
    
    var activePanel:SearchPanel!;
    var began_location_x :Int = 1;
    var began_location_y :Int = 1;
    var former_screen = "";
    
    var userInformationNode : BattleUserInformationNode!
    var units_hpsum : Hpsum!;
    var dvunits : [BattleUnit] = [];
    
    var dungeon_id : Int = 0;
    
    //生成する探索パネルのタイプをリストにしてます
    //現時点では「battle=赤色のパネル」「none=青色のパネル」にしてます
    var type_list = ["battle","battle","none","none","none","battle","battle","none","none","none","battle","battle","none","none","none","battle","battle","none","none","none","battle","battle","none","none","none",];
    var generator_flag = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    
    var born : SearchBornGenerate!;
    var activeBorn : SearchBorn!;
    var click_panel : Int = 0;
    var born_panel : Int = 0;
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        
        
        if former_screen != "battle"{
            initPanelGenerate();
            self.userInformationNode = (self.childNode(withName: "UserInformationNode") as! BattleUserInformationNode)
            var config = Realm.Configuration()
            config.deleteRealmIfMigrationNeeded = true
            let realm = try! Realm(configuration: config);
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            let dvunits_d = realm.objects(DVUnit.self)
            for dvunit_d in dvunits_d{
                let data = try! JSONEncoder().encode(dvunit_d)
                let jsonStr = String(data: data, encoding: .utf8);
                print(jsonStr!)
                let unitData = jsonStr!.data(using: .utf8)
                let dvunit = try! JSONDecoder().decode(BattleUnit.self, from: unitData!);
                dvunit.setSkilltoBelong();
                self.dvunits.append(dvunit)
            }
            userInformationNode.setImageToChildren(node_lis: self.dvunits);
            initHPsum();
        }else{
//            self.generators = UserDefaults.standard.array(forKey: "panel_generater") as! [SearchPanelGenerate];
//            self.generator_flag = UserDefaults.standard.array(forKey: "panel_flag") as! [Int];
//            self.born = UserDefaults.standard.data(forKey: "born");
//            self.addChild(generators)
            for g in generators{
                self.addChild(g);
                g.pal?.zPosition = g.zPosition + 1;
                self.addChild(g.pal!);
            }
            self.addChild(born.pal!);
            self.addChild(born);
            self.addChild(userInformationNode);
        }

        
    }
    
    func initHPsum(){
        var units_hpsum = Hpsum();
        var backgroundView = userInformationNode.childNode(withName: "backgroundbar") as! SKSpriteNode;
        units_hpsum.inithp(units: dvunits, x: Int(Float(backgroundView.position.x) - (Float(backgroundView.size.width) / 2)), y: Int(Float(backgroundView.position.y)  - (Float(backgroundView.size.height) / 2)));

        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: units_hpsum.width, height: units_hpsum.height));
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: units_hpsum.position.x, y: units_hpsum.position.y);
        backgroundBar.size = CGSize(width: units_hpsum.width, height: units_hpsum.height);
        self.userInformationNode.units_hpsum = units_hpsum
        self.userInformationNode.addChild(units_hpsum);
        self.userInformationNode.addChild(backgroundBar)
    }
    
    
    
    
    let len : Int = 25; // 表示するcontainerとgeneratorの数
    var generators:[SearchPanelGenerate] = [];//パネル生成ボックスのリスト
    
    
    func initPanelGenerate(){
        let value = self.type_list[0];
        var x_point : Int = 0;
        var y_point : Int = 0;
        let br :SearchBornGenerate = SearchBornGenerate();
        
        //探索パネルと駒を初期位置に生成する
        for i in 0..<self.len{
            var len=self.type_list.count;
            var ran = Int.random(in:0..<len);
            var panel=type_list.remove(at:ran);
            let pg : SearchPanelGenerate = SearchPanelGenerate(panel_type:panel);

            var num = Int(i);
            
            //
            if num >= 0 && 4>=num {
                y_point = 285;
            }else if num >= 5 && 9>=num{
                y_point = 135;
            }else if num >= 10 && 14>=num{
                y_point = -15;
            }else if num >= 15 && 19>=num{
                y_point = -165;
            }else{
                y_point = -315;
            }
            
            
            
            if i == 22{
                br.setpoint(x: -250 + x_point * 125, y: y_point);
                br.zPosition = 5;
                self.born_panel = num;
                self.born=br;
                br.generate();
            }
            
            pg.setpoint(x:-300 + x_point * 151 ,y : y_point);//パネル生成の箱の位置
            x_point+=1
            if x_point==5{
                x_point=0
            }
            
            self.generators.append(pg);
            pg.generate();
            self.addChild(pg.pal!);
            self.addChild(pg);
            
            if i==22{
                self.addChild(br.pal!);
                self.addChild(br);
            }
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
            let location = pos;
            for i in 0..<self.generators.count{
                if (generators[i].contain(touchX: Int(location.x), touchY: Int(location.y))){
    //              print(generators[i].x, generators[i].y);
                    self.activePanel = generators[i].pal;
                    self.activeBorn = born.pal;
                    self.began_location_x  = Int(self.activePanel.position.x);
                    self.began_location_y  = Int(self.activePanel.position.y);
                }
            }
        //print("ここでタッチ判定してるんだなぁみつを"); ここでタッチ判定
        
        
        if activePanel != nil { // 選択中のpanelが存在する場合
            var userDefaults = UserDefaults.standard
            
            var interacted_born_index = getInteractedContainerBorn(pos: pos);
            var interacted_pc_index = getInteractedContainerIndex(pos: pos);
            var flag = false;
            
            if interacted_born_index != -1 {
                self.click_panel = interacted_pc_index;
            }
            
            if interacted_pc_index != -1 {
                if self.born_panel == interacted_pc_index - 1 || self.born_panel == interacted_pc_index + 1 || self.born_panel == interacted_pc_index - 5 || self.born_panel == interacted_pc_index + 5{
                    flag = true;
               
                }
                
                //移動した先に探索パネルと駒を生成
                if flag == true{
                    var panel_type=String(generators[interacted_pc_index].type);
                    self.generators.remove(at: interacted_pc_index);
                    self.born.removeFromParent();
                    self.born.pal!.removeFromParent();
                    let pg : SearchPanelGenerate = SearchPanelGenerate(panel_type:panel_type);
                    let br :SearchBornGenerate = SearchBornGenerate();

                    pg.setpoint(x:began_location_x ,y : began_location_y);
                    pg.zPosition=5;
                    self.generators.insert(pg, at: interacted_pc_index);
                    pg.re_generate();
                    self.generator_flag.remove(at: interacted_pc_index);
                    self.generator_flag.insert(1, at: interacted_pc_index);
                    self.addChild(pg.pal!);
                    self.addChild(pg);
                    
                    br.setpoint(x: began_location_x, y: began_location_y);
                    br.zPosition = 6;
                    self.born=br;
                    br.generate();
                    
                    self.addChild(br.pal!);
                    self.addChild(br);
                    
                    //現在いるパネルが何をするかの確認
                    print(pg.type);
                    //この関数にシーン遷移の処理を書いたらおそらくいけます
                    self.born_panel = interacted_pc_index;
                    self.panelJudge(panel_type: pg.type);
                    
//                    userDefaults.set(self.generators,forKey: "panel_generater");
//                    userDefaults.set(self.generator_flag,forKey: "panel_flag");
//                    userDefaults.set(br,forKey: "born");
                    
                    
                }
            }
        }
        
        
        }
    
    func panelJudge(panel_type:String){
        if panel_type=="battle"{
            print("戦闘開始");
            let scene = GameScene(fileNamed: "GameScene");
            scene?.scaleMode = .aspectFill;
            self.userInformationNode.removeFromParent();
            scene?.userInformationNode = self.userInformationNode;
            scene?.searchPanelGenerators = self.generators;
            scene?.searchGeneratorFlag = self.generator_flag;
            scene?.searchBorn = self.born
            scene?.born_panel = self.born_panel;
            self.view!.presentScene(scene);
        }else if panel_type=="none"{
            print("何もないところ");
        }
    }
                
    func touchMoved(toPoint pos : CGPoint) {
    //ここがパネル動くやつ
//        if (activePanel != nil){
//            let location = pos;
//            self.activePanel.setPosition(x: Int(location.x), y: Int(location.y));
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//            if (activePanel != nil){ // 選択中のpanelが存在する場合
//                var interacted_pc_index = getInteractedContainerIndex(pos: pos); // 離した座標から、どのcontainerかを判別。具体的には、self.containersのインデックスを返す。どのcontainerも含まれてなかったと判断したら、-1を返す。
//
//                if (interacted_pc_index != -1){ // 1 タップを離した部分の座標がcontainerに含まれる時
//                    if countjudge{
//                        countable = true//カウントするためのフラグを立てる。また５秒経ったらfalseになる
//                        startDate = NSDate();//開始時間
//                    }
//                    countjudge = false;
//                    if self.containers[interacted_pc_index].addPanel(panel: self.activePanel,judgeflag : countable)&&countable{ // 1.1 containerの容量が空いていたら
//                        for i in 0..<len{ //generate処理
//                            if( generators[i].pal == self.activePanel){
//                                generators[i].destroyPanel();
//                                generators[i].generate();
//                                self.addChild(generators[i].pal!);
//                            }
//                        }
//                    }else{ // 1.2 containerの容量が空いていなかったら(満タンだったら)
//                        backToBeginPoint();
//                    }
//    //                print("実行すスキルは?");
//    //                print(self.u.getexecutable(container: containers[interacted_pc_index])[0].name);
//
//
//                }else{  // 2 containerに含まれない時
//                    backToBeginPoint();
//                }
//
//                self.activePanel = nil;
//            }
        }
    
//    func backToBeginPoint(){
//        self.activePanel.position = CGPoint(x: self.began_location_x, y: self.began_location_y);
//    }
    
    func getInteractedContainerIndex(pos : CGPoint) -> Int{
        var all_nodes = self.nodes(at: pos);
        var i : Int = -1;
        for node_ in all_nodes{
            for i in 0..<self.generators.count{
                if (generators[i] == node_){
                    return i;
                }
            }
        }
        return i;
    }
    
    func getInteractedContainerBorn(pos : CGPoint) -> Int{
        var all_nodes = self.nodes(at: pos);
        var i : Int = -1;
        for node_ in all_nodes{
            for i in 0..<all_nodes.count{
                if (self.born == node_){
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
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
            
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
