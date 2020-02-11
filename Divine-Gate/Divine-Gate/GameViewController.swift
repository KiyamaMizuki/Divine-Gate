//
//  GameViewController.swift
//  Divine-Gate
//
//  Created by 宮里　佳音 on 2019/11/09.
//  Copyright © 2019 宮里　佳音. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit
import RealmSwift

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initDatabase();
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = TitleScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    func initDatabase(){
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        let realm = try! Realm(configuration: config);
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let dungeon = Dungeon()
//        let dungeon_enemy = DungeonEnemy()
//        let enemy_model = EnemyModel()
        
        try! realm.write{
//            dungeon_enemy.id = 1
//            dungeon_enemy.dungeon_id = 1
//            dungeon_enemy.enemy_id = 1
//            realm.add(dungeon)
//            realm.add(dungeon_enemy)
//            realm.add(enemy_model)
//            dungeon.id = 1
//            dungeon.name = "dungeon1"
//            realm.add(dungeon)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet var labeltest :UILabel!
//    @IBOutlet var buttonTest :UIButton!
//
//    var count = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        labeltest.text = "Swift Test"
//
//        buttonTest.setTitle("Button",for:UIControl.State.normal)
//
//    }
//
//    @IBAction func buttonTapped(_ sender : Any) {
//        count += 1
//        if(count%2 == 0){
//            labeltest.text = "Swift Test"
//        }
//        else{
//            labeltest?.text = "tapped !"
//        }
//    }
//
//}
