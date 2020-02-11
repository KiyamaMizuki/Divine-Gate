//
//  DungeonSelectScene.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import RealmSwift

class DungeonSelectScene : SKScene{
    var button_num : Int = 2;
    var buttons : [Button] = [];
    var dungeons : [Dungeon] = [];
    override func didMove(to view: SKView) {
        self.name = "dungeon_select";
        
        var config = Realm.Configuration()
//        config.deleteRealmIfMigrationNeeded = true
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do{
            let realm = try Realm();
            var dungeons_r = realm.objects(Dungeon.self)
            print(dungeons_r.first!)
            for dungeon in dungeons_r{
                print(dungeon);
                var dungeon_model = Dungeon()
                dungeon_model.id = dungeon.id
                dungeon_model.name = dungeon.name
                dungeons.append(dungeon_model);
            }
        } catch let error as NSError{
            fatalError("Error opening realm: \(error)")
        }
        
        
        
        initButtons();

    }
    
    func initButtons(){
        for i in 0..<button_num{
            var name = "button";
            name += String(i);
            print(name)
            var button = self.childNode(withName: name) as! Button;
            button.id = i;
            button.isUserInteractionEnabled = true;
            var label = button.childNode(withName: "Label") as! SKLabelNode;
            label.text = self.dungeons[button.id].name;
            button.setTouchUp {
                let scene = Search(fileNamed: "Search");
                scene?.scaleMode = .aspectFill
                scene!.former_screen = self.name!
                scene?.dungeon = self.dungeons[button.id];
                self.view!.presentScene(scene)
                
            }
        }
    }
}

