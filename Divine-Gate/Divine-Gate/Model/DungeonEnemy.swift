//
//  DungeonEnemy.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import RealmSwift
class DungeonEnemy : Object{
    @objc dynamic var id = 0
    @objc dynamic var dungeon_id = 0
    @objc dynamic var enemy_id = 0
}
