//
//  Dungeon.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import RealmSwift

class Dungeon : Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var dungeon_enemy_id : Int = 0
    
//    required init(id : Int, name : String, dungeon_enemy_id : Int){
//        self.id = id;
//        self.name = name;
//        self.dungeon_enemy_id = dungeon_enemy_id;
//    }
//    
//    override required init() {
//        fatalError("init() has not been implemented")
//    }
    
//    override required init() {
//        fatalError("init() has not been implemented")
//    }
}
