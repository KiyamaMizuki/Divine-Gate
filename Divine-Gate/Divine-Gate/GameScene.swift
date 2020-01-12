//
//  GameScene.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//

import SpriteKit
import GameplayKit
import RealmSwift

class GameScene: SKScene {

    var activePanel:Panel!; // 操作対象にあるパネルを指す
    var timerLabel : TimerLabel!
    let len : Int = 5; // 表示するcontainerとgeneratorの数
    let unit_num : Int = 5; // ユニットの数
    var began_location_x :Int = 1;// activePanelの初期x座標. container外でタップが離されたときに元のPanelGenerateに戻すときに使う
    var began_location_y :Int = 1;// activePanelの初期y座標. 同上.
    var startDate : NSDate = NSDate();//開始時間
    var first_insert = true;
    var generators:[PanelGenerate] = []; //パネル生成ボックスのリスト
    var containers:[PanelContainer] = []; //パネル収容ボックスのリスト
    var dvunits : [DVUnit] = [];
    var units_hpsum : Hpsum!;
    var queues : [NormalSkillQueue] = [];
    var enemy : Enemy!;
    var hpsum : Hpsum!;
    
    var attack_span = 3;
    var attack_num = 0;
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        
        self.timerLabel = TimerLabel();
            
        initPanelGenerate();
        initPanelContainer();
        
        

//
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        let realm = try! Realm(configuration: config);
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        // dataReset(realm: realm) // 全てのレコードを削除
        // dataInsert(realm: Realm) // データをinsertする
        

        
        let dvunits_d = realm.objects(DVUnit.self)
        
        for dvunit_d in dvunits_d{
            let data = try! JSONEncoder().encode(dvunit_d)
            let jsonStr = String(data: data, encoding: .utf8);
            print(jsonStr!)
            let unitData = jsonStr!.data(using: .utf8)
            let dvunit = try! JSONDecoder().decode(DVUnit.self, from: unitData!);
            dvunit.setSkilltoBelong();
            self.dvunits.append(dvunit)
        }
        
        
        
        

        
        self.enemy = Enemy(type: "fire", enemywidth: 500, enemyheight: 500, image_path: "monster01");
        enemy.setPosition(x: 0, y: 400);

        // 体力表示
        initHPsum();
        initEnemyHPsum();
        // normalSkillキュー初期化
        initQueues();
        
        self.addChild(enemy);
        self.addChild(timerLabel);
        print("name of this scene: " + self.name!);
    }
    
    func dataInsert(realm : Realm){
        var unitStr1 = """
            {
                "name":"testunit",
                "type":"fire",
                "tribe":"human",
                "description_c":"this is test unit",
                "image_path":"hoge",
                "id":"1",
                "rarelity":0,
                "hp":100,
                "attack":10,
                "level":5,
                "plus":10,
                "normalSkills":[
                    {
                        "requirePanels":{
                            "id":1,
                            "fire":2,
                            "water":0,
                            "wind":0,
                            "light":0,
                            "dark":0
                        },
                        "id" : 1,
                        "ratio":3.0,
                        "toSingle": true,
                        "skillType": "attack",
                        "name": "fire2skill",
                        "executable":false,
                        "description_c": "fuga",
                        "type": "fire"
                    },
                    {
                        "requirePanels":{
                            "id":2,
                            "fire":1,
                            "water":0,
                            "wind":0,
                            "light":0,
                            "dark":0
                        },
                        "id":2,
                        "ratio":2.0,
                        "toSingle": true,
                        "skillType": "attack",
                        "name": "fire1skill",
                        "executable":false,
                        "description_c": "fuga",
                        "type": "fire"
                    }
                ],
                "isLeader":true,
                "isSelected": true,
            }
            """;
        var unitStr2 = """
        {
            "name":"testunit2",
            "type":"water",
            "tribe":"human",
            "description_c":"this is test unit",
            "image_path":"hoge",
            "id":"2",
            "rarelity":0,
            "hp":100,
            "attack":10,
            "level":5,
            "plus":10,
            "normalSkills":[
                {
                    "requirePanels":{
                        "id":3,
                        "fire":0,
                        "water":1,
                        "wind":0,
                        "light":0,
                        "dark":0
                    },
                    "id":3,
                    "ratio":1.2,
                    "toSingle": true,
                    "skillType": "attack",
                    "name": "water1skill",
                    "executable":false,
                    "description_c": "piyo",
                    "type": "water"
                }
            ],
            "isLeader":true,
            "isSelected":true,
        }
        """;
        
        
        let unitData1 = unitStr1.data(using: .utf8)
        let unitData2 = unitStr2.data(using: .utf8)
        let dvunit1 = try! JSONDecoder().decode(DVUnit.self, from: unitData1!);
        let dvunit2 = try! JSONDecoder().decode(DVUnit.self, from: unitData2!);
        
        try! realm.write {
            realm.add(dvunit1)
            realm.add(dvunit2)
        }
        
    }
    
    func dataReset(realm: Realm){
        let dvunits_d = realm.objects(DVUnit.self)
        dvunits_d.forEach{ i in
            try! realm.write(){
                realm.delete(i)
            }
        }
        
        let rpm = realm.objects(RequirePanelModel.self)
        rpm.forEach{ i in
            try! realm.write(){
                realm.delete(i)
            }
        }
        
        let normalSkill_d = realm.objects(NormalSkill.self)
        normalSkill_d.forEach{ i in
            try! realm.write(){
                realm.delete(i)
            }
        }
        
        

        
    }
    
    func initHPsum(){
        self.units_hpsum = Hpsum();
        self.units_hpsum.inithp(units: dvunits, x: -260, y: -200); // 1. inithpメソッドをよび、setProgressを利用する

        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: self.units_hpsum.width, height: self.units_hpsum.height)); // 背景色の色
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: self.units_hpsum.position.x, y: self.units_hpsum.position.y);
        backgroundBar.size = CGSize(width: self.units_hpsum.width, height: self.units_hpsum.height);

        self.addChild(self.units_hpsum);
        self.addChild(backgroundBar)
    }
    
    func initEnemyHPsum(){
        var hpsum = Hpsum();
        hpsum.inithp(num: 100, x: 0, y: 70); // 1. inithpメソッドをよび、setProgressを利用する

        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: hpsum.width, height: hpsum.height));
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: hpsum.position.x, y: hpsum.position.y);
        backgroundBar.size = CGSize(width: hpsum.width, height: hpsum.height);
        self.enemy.hpsum = hpsum;
        self.addChild(self.enemy.hpsum);
        self.addChild(backgroundBar)
    }
    
    func initQueues(){
        for i in 0..<self.len{
            var queue : NormalSkillQueue = NormalSkillQueue();
            
            queue.setpoint(x:-250 + i * 125 ,y : 0);//パネル生成の箱の位置
            self.queues.append(queue);
            self.addChild(queue);
        }
    }
    
    /*
        5つのPanelGenerateインスタンスを用意してSceneに配置
     */
    func initPanelGenerate(){
        //パネル生成のクラス
        for i in 0..<self.len{
            let pg : PanelGenerate = PanelGenerate();

            
            pg.setpoint(x:-250 + i * 125 ,y : -450);//パネル生成の箱の位置
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
            pc.position = CGPoint(x: -250 + i * 125 , y : -300);//パネルコンテナボックスの位置
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
            var interacted_pc_index = getInteractedContainerIndex(pos: pos);
            
            
            if (interacted_pc_index != -1){ // 1 タップを離した部分の座標がcontainerに含まれる時
                if first_insert{
                    timerLabel.start();
                }
                first_insert = false;
                if self.containers[interacted_pc_index].addPanel(panel: self.activePanel){   // 1.1 containerの容量が空いていたら
                    for i in 0..<len{ //generate処理
                        if( generators[i].pal == self.activePanel){
                            generators[i].destroyPanel();
                            generators[i].generate();
                            self.addChild(generators[i].pal!);
                        }
                    }
                    insertExecutableSkill(index : interacted_pc_index); // queueに実行可能なスキルを格納する
                }else{ // 1.2 containerの容量が空いていなかったら(満タンだったら)
                    backToBeginPoint();
                }
            }else{  // 2 containerに含まれない時
                backToBeginPoint();
            }

            self.activePanel = nil;
        }
    }
    
    func insertExecutableSkill(index : Int){  // indexに指定したコンテイナーの情報をもとに、
        self.queues[index].delete();
        for unit in self.dvunits{
            var normalskills : [NormalSkill] = unit.getexecutable(container: self.containers[index])
            for ns in normalskills{
                var nsview = SkillView(viewWidth: self.queues[index].width, viewHeight: self.queues[index].width / 8, normalSkill: ns)
                self.queues[index].insert(inserted_skill_view: nsview);
            }
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
    
    func executeSkill(){ // queueに格納されているスキルを全て実行し、queueの中身を空っぽにする
        for queue in self.queues{
            for skillView in queue.skillqueue{
                skillView.normalSkill.execute(hpsum: self.units_hpsum, enemies: [self.enemy], enemy_index: 0);
            }
            queue.delete()
        }
    }
    
    /*
        container外でactivePanelをタップする指が離されたときに、元の位置に戻す関数.
     */
    func backToBeginPoint(){
        self.activePanel.position = CGPoint(x: self.began_location_x, y: self.began_location_y);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{ self.touchDown(atPoint: touch.location(in: self)) }
    }
            
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{ self.touchMoved(toPoint: touch.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
            
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

            
    override func update(_ currentTime: TimeInterval) {
        timerLabel.update()
        if timerLabel.count <= 0{
            updateState();
            initState();
        }
    }
    
    func updateState(){
        executeSkill();
        attack_num += 1;
        if (attack_num == attack_span){
            attackFromEnemy();
            attack_num = 0;
        }
        timerLabel.reset();
        first_insert = true;
    }
    

    
    func attackFromEnemy(){  // enemyからの攻撃を受ける
        self.units_hpsum.wounded(damage:10, type:"fire");
    }
    
    func initState(){ // stateを初期化して、サイクルを繰り返す、
        for container in containers{
            self.removeChildren(in: container.panels);
            container.removeAll();
        }
    }
}
