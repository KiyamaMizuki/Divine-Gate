//
//  EnemyModel.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/02/11.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import RealmSwift
class EnemyModel : Object{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var attack = 0
    @objc dynamic var image_path = ""
    @objc dynamic var rarelity = 0
    @objc dynamic var hp = 0
}
