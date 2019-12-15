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
    let unit_num : Int = 5; // ユニットの数
    var began_location_x :Int = 1;// activePanelの初期x座標. container外でタップが離されたときに元のPanelGenerateに戻すときに使う
    var began_location_y :Int = 1;// activePanelの初期y座標. 同上.
    var startDate : NSDate = NSDate();//開始時間
    var countable = false;//カウントする為のフラグ
    var countjudge = true;//countableの値を変えない為のフラグ
    let labeli = SKLabelNode(fontNamed: "Verdana")//文字を扱うための変数labeli
                                                  //"Verdana"はフォントの名前
    let skillLabel = SKLabelNode(fontNamed: "Verdana");
    var dateFormatter = DateFormatter();//日付と時刻を表現
    var generators:[PanelGenerate] = [];//パネル生成ボックスのリスト
    var containers:[PanelContainer] = [];//パネル収容ボックスのリスト
    var dvunits : [DVUnit] = [];
    var units_hpsum : Hpsum!;
    var queues : [NormalSkillQueue] = []; // queue
    var enemy : Enemy!;
    let screenwidth = UIScreen.main.bounds.size.width//スマホの横幅
    let screenheight = UIScreen.main.bounds.size.height//スマホの横幅
//    var u : DVUnit = DVUnit();
    var hpsum : Hpsum!;
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        initPanelGenerate();
        initPanelContainer();
        initLabel();
//        initSkillLabel();
        var unitStr1 = """
            {
                "name":"testunit",
                "type":"fire",
                "tribe":"human",
                "description":"this is test unit",
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
                            "fire":2,
                            "water":0,
                            "wind":0,
                            "light":0,
                            "dark":0
                        },
                        "ratio":3.0,
                        "toSingle": true,
                        "skillType": "attack",
                        "name": "fire2skill",
                        "executable":false,
                        "description": "fuga",
                        "type": "fire"
                    },
                    {
                        "requirePanels":{
                            "fire":1,
                            "water":0,
                            "wind":0,
                            "light":0,
                            "dark":0
                        },
                        "ratio":2.0,
                        "toSingle": true,
                        "skillType": "attack",
                        "name": "fire1skill",
                        "executable":false,
                        "description": "fuga",
                        "type": "fire"
                    }
                ],
                "isLeader":true,
            }
            """;
        var unitStr2 = """
        {
            "name":"testunit2",
            "type":"water",
            "tribe":"human",
            "description":"this is test unit",
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
                        "fire":0,
                        "water":1,
                        "wind":0,
                        "light":0,
                        "dark":0
                    },
                    "ratio":1.2,
                    "toSingle": true,
                    "skillType": "attack",
                    "name": "water1skill",
                    "executable":false,
                    "description": "piyo",
                    "type": "water"
                }
            ],
            "isLeader":true,
        }
        """;
        let unitData1 = unitStr1.data(using: .utf8)
        let unitData2 = unitStr2.data(using: .utf8)
        let dvunit1 = try! JSONDecoder().decode(DVUnit.self, from: unitData1!);
        let dvunit2 = try! JSONDecoder().decode(DVUnit.self, from: unitData2!);
        print(dvunit1.name, dvunit1.level, dvunit1.plus, dvunit1.isLeader);
        print(dvunit2.name, dvunit2.level, dvunit2.plus, dvunit2.isLeader);
        dvunit1.setSkilltoBelong();
        dvunit2.setSkilltoBelong();
        dvunits.append(dvunit1);
        dvunits.append(dvunit2);
        
        self.enemy = Enemy(type: "fire", enemywidth: 500, enemyheight: 500, image_path: "monster01");
        enemy.setPosition(x: 0, y: 400);

        // 体力表示
        initHPsum();
        initEnemyHPsum();
        // normalSkillキュー初期化
        initQueues();
        
        self.addChild(enemy);
        print("name of this scene: " + self.name!);
    }
    
    func initLabel(){
        self.labeli.color = UIColor(named: "white");//表示される文字の色?
        self.labeli.fontSize = 100;//文字のサイズ
        self.labeli.zPosition = 100;//文字のZ座標
        self.labeli.fontColor = UIColor.white;//表示される文字の色
        self.labeli.text = "Divine:"; //画面に表示される文字
        self.labeli.position = CGPoint(x: 0, y: 150)//文字の位置を指定
        //self.labeli
        labeli.name = "buttonLabel"
        
        self.addChild(labeli);
    }
    
    func initSkillLabel(){
        self.skillLabel.color = UIColor(named: "white");//表示される文字の色?
        self.skillLabel.fontSize = 30;//文字のサイズ
        self.skillLabel.zPosition = 100;//文字のZ座標
        self.skillLabel.fontColor = UIColor.white;//表示される文字の色
        self.skillLabel.text = "skilllabel"; //画面に表示される文字
        self.skillLabel.position = CGPoint(x: 0, y: 400)//文字の位置を指定
        //self.skillLabel
        skillLabel.name = "buttonLabel"
        
        self.addChild(skillLabel);
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
        hpsum.inithp(units: dvunits, x: 0, y: 70); // 1. inithpメソッドをよび、setProgressを利用する

        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: hpsum.width, height: hpsum.height));
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: hpsum.position.x, y: hpsum.position.y);
        backgroundBar.size = CGSize(width: hpsum.width, height: hpsum.height);
        self.enemy.hpsum = hpsum;
        self.addChild(self.enemy.hpsum);
        self.addChild(backgroundBar)
    }
    
    func initQueues(){
//        for i in 0..<self.len{
//            var queue : NormalSkillQueue = NormalSkillQueue();
//            self.queues.append(queue);
//            self.addChild(queue)
//        }
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
    
//    func initUVUnit(){
//        for i in 0..<self.unit_num{
//            var
//        }
//    }
    
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
                    insertExecutableSkill(index : interacted_pc_index); // queueに実行可能な
                    displayExecutableSkill(index: interacted_pc_index);
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
    
    func insertExecutableSkill(index : Int){
        
        self.queues[index].skillqueue = [];
        self.queues[index].delete();
        for unit in self.dvunits{
            var normalskills : [NormalSkill] = unit.getexecutable(container: self.containers[index])
            for ns in normalskills{
                var nsview = SkillView(viewWidth: self.queues[index].width, viewHeight: self.queues[index].width / 8, normalSkill: ns)
                self.queues[index].insert(inserted_skill_view: nsview);
            }
        }
    
    }
    
    func displayExecutableSkill(index : Int){
        var displayStr : String = "container" + String(index) + ": ";
        for skillview in self.queues[index].skillqueue{
            displayStr += skillview.normalSkill.name;
            displayStr += " ";
        }
        self.skillLabel.text = displayStr;
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
        }
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
            if time > 8.0{
                countable = false;
                executeSkill();
            }
        }
     //   Called; before; each; frame is rendered
    }
    

}
