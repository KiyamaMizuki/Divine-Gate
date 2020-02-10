//
//  SearchScene.swift
//  Divine-Gate
//
//  Created by 長濱北斗 on 2020/01/16.
//  Copyright © 2020 宮里　佳音. All rights reserved.
//

import Foundation
import SpriteKit
import RealmSwift

class SearchScene : SKScene{
    var userInformationNode : BattleUserInformationNode!
    var units_hpsum : Hpsum!;
    var dvunits : [BattleUnit] = [];

    
    override func didMove(to view: SKView) {
        self.userInformationNode = self.childNode(withName: "UserInformationNode") as! BattleUserInformationNode
        
        
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
}
