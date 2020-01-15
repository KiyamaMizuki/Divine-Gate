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
    var dvunits : [BattleUnit] = [];
    var units_hpsum : Hpsum!;
    var queues : [NormalSkillQueue] = [];
    var enemy : Enemy!;
    var hpsum : Hpsum!;
    var userInformationNode : BattleUserInformationNode!
    var enemyDivNode : EnemyDivNode!;
    
    var attack_span = 3;
    var attack_num = 0;
    
    override func didMove(to view: SKView) {
        self.name = "battle";
        
        self.timerLabel = TimerLabel();
            
        initPanelGenerate();
        initPanelContainer();
        
        self.userInformationNode = self.childNode(withName: "UserInformationNode") as! BattleUserInformationNode
        
//
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
        
        self.enemyDivNode = childNode(withName: "EnemyDivNode") as! EnemyDivNode;
        
        
        

        
        self.enemy = Enemy(type: "fire", enemywidth: 500, enemyheight: 500, image_path: "monster01");
        enemy.setPosition(x: 0, y: 400);

        initHPsum();
        initEnemyHPsum();
        initQueues();
        
        self.addChild(enemy);
        self.addChild(timerLabel);
        print("name of this scene: " + self.name!);
    }
    
    func setBackGroundImage(){
        let background = SKSpriteNode(imageNamed: "dungeon")
        background.size = self.size
        background.zPosition = -1
        self.addChild(background)
    }
    
    
    func initHPsum(){
        self.units_hpsum = Hpsum();
        self.units_hpsum.inithp(units: dvunits, x: -290, y: 68);
        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: units_hpsum.width, height: units_hpsum.height));
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: self.units_hpsum.position.x, y: self.units_hpsum.position.y);
        backgroundBar.size = CGSize(width: self.units_hpsum.width, height: self.units_hpsum.height);

        self.userInformationNode.addChild(self.units_hpsum);
        self.userInformationNode.addChild(backgroundBar)
    }
    
    func initEnemyHPsum(){
        var hpsum = Hpsum();
        hpsum.inithp(num: 100, x: -20, y: -195);
        let backgroundBar = SKSpriteNode(color: UIColor.gray, size: CGSize(width: hpsum.width, height: hpsum.height));
        backgroundBar.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundBar.position = CGPoint(x: hpsum.position.x, y: hpsum.position.y);
        backgroundBar.size = CGSize(width: hpsum.width, height: hpsum.height);
        self.enemy.hpsum = hpsum;
        self.enemyDivNode.addChild(self.enemy.hpsum);
        self.enemyDivNode.addChild(backgroundBar)
    }
    
    func initQueues(){
        for i in 0..<self.len{
            let queue : NormalSkillQueue = (self.childNode(withName: "skillQueue"+String(i+1)) as? NormalSkillQueue?)!!;
            self.queues.append(queue);
        }
    }
    
    /*
        5つのPanelGenerateインスタンスを用意してSceneに配置
     */
    func initPanelGenerate(){
        //パネル生成のクラス
        for i in 0..<self.len{
            let pg : PanelGenerate = (self.childNode(withName: "PanelGenerate"+String(i+1)) as? PanelGenerate?)!!;
            self.generators.append(pg);
            pg.generate();
            self.addChild(pg.pal!);
        }
    }
    
    /*
        5つのPanelContainerインスタンスを用意してSceneに配置
     */
    func initPanelContainer(){
        for i in 0..<self.len{
            let pc: PanelContainer = (self.childNode(withName: "PanelContainer"+String(i+1)) as? PanelContainer?)!!;
            self.containers.append(pc);
        }
    }
    
    
    /*
        touchesbeginから呼ばれる
     */
    func touchDown(atPoint pos : CGPoint) {
        let location = pos;
        for i in 0..<self.generators.count{
            if (generators[i].contain(touchX: Float(location.x), touchY: Float(location.y))){
                self.activePanel = generators[i].pal;
                self.began_location_x  = Int(self.activePanel.position.x);
                self.began_location_y  = Int(self.activePanel.position.y);
            }
        }
    }
    
    func getUnderNode(pos: CGPoint) -> [SKNode]{ // 下のノードの配列を取得する
        let under_nodes = nodes(at: pos);
        return under_nodes
    }
    
    func isOnNode(pos : CGPoint, nodename : String) -> Bool{ //
        let under_nodes = getUnderNode(pos: pos);
        for under_node in under_nodes{
            let name = String(describing: Swift.type(of: under_node))
            if nodename == name{
                return true;
            }
        }
        return false;
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
            var normalskills : [BattleNormalSkill] = unit.getexecutable(container: self.containers[index])
            for ns in normalskills{
                var nsview = SkillView(viewWidth: Int(self.queues[index].size.width), viewHeight: Int(self.queues[index].size.width / 8), normalSkill: ns)
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
        if enemy.hpsum.hp < 0{
             let scene = EmptyScene(fileNamed: "EmptyScene");
             scene?.scaleMode = .aspectFill
             self.view!.presentScene(scene)
        }
        attack_num += 1;
        if (attack_num == attack_span){
            attackFromEnemy();
            attack_num = 0;
        }
        timerLabel.reset();
        first_insert = true;
    }
    

    
    func attackFromEnemy(){
        self.units_hpsum.wounded(damage:10, type:"fire");
    }
    
    
    func initState(){
        for container in containers{
            self.removeChildren(in: container.panels);
            container.removeAll();
        }
    }
}
