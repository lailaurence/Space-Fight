//
//  GameScene.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 7/7/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseInAppMessaging



//Score things
class GameScene: SKScene {
var currentLevel = 0
var levelMinimum = 0
   
    
   

    
    

    let startLabel = SKLabelNode(fontNamed:"Courier New Bold")
    
    override func didMove(to view: SKView) {
        
        
        func xpdata(data:Int){
            
        }
        //MARk: Read XP Data
        /*
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserDefaults.standard.set(uid, forKey: "UserID")
        let ref = Database.database().reference(withPath: "High Score")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot) // Its print all values including Snap (User)
            
            print(snapshot.value!)
            
            //let xp = snapshot.childSnapshot(forPath: "XP").value
            
            let xpdata:Int = snapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "xp").value as! Int
            print("XP: \(xpdata)")
            UserDefaults.standard.set(xpdata, forKey: "UserXP")
            
            
        })
        
        
        */
        //MARK: Level System
        let userxp:Int = UserDefaults.standard.object(forKey: "UserXP") as? Int ?? 0
        print("\(userxp) GAME SCENNEEEE")
        
        switch userxp {
        case 0...10:
            var currentLevel = 1
            var levelMinimum = 10
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
        case 11...20:
            var currentLevel = 2
            var levelMinimum = 20
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
        case 21...30:
            var currentLevel = 3
            var levelMinimum = 30
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
        case 31...40:
            var currentLevel = 4
            var levelMinimum = 40
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
        case 41...50:
            var currentLevel = 5
            var levelMinimum = 50
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
        case 51...100:
            var currentLevel = 6
            var levelMinimum = 100
            UserDefaults.standard.set(levelMinimum, forKey: "xpMinimum")
            UserDefaults.standard.set(currentLevel, forKey: "UserLevel")
            
        default:
            print("Error occured: XP doesn't recognized!")
        }
        
        

        
        //background
        let background = SKSpriteNode(imageNamed: "background2")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        
  
            
       
        //Level Label
        let levelLabel = SKLabelNode(fontNamed: "Courier New Bold")
        let UserLevel = UserDefaults.standard.object(forKey: "UserLevel")
        levelLabel.text = "Level \(UserLevel) "
        print("Level \(UserLevel)")
        
        
        
        
        let xpLabel = SKLabelNode(fontNamed: "Courier New Bold")
        let XPMax = UserDefaults.standard.object(forKey: "xpMinimum")
        xpLabel.text = "XP:\(userxp)/\(XPMax) "
        print("XP:\(userxp)/\(XPMax)")
        
        
        
        
        //MARK: Username display
        let x = UserDefaults.standard.object(forKey: "usernameSaved")
        let usernameLabel = SKLabelNode(fontNamed: "Courier New Bold")
        usernameLabel.text = "Username: \((x as! String))"
        usernameLabel.fontSize = 45
        usernameLabel.fontColor = SKColor.white
        usernameLabel.position = CGPoint(x:520,y: 1800)
        usernameLabel.zPosition = 1
        self.addChild(usernameLabel)
        print("Displayed UsernameLabel")
     
        
        
        
        //MARK: Game Title
       
        let titleLabel = SKLabelNode(fontNamed:"Courier New Bold")
        titleLabel.text = "Space Fight"
        titleLabel.fontSize = 130
        titleLabel.fontColor = SKColor.white
        titleLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        titleLabel.zPosition = 1
        self.addChild(titleLabel)
        print("Displayed game title")
        
        
        
        
        
        
        
        //MARK: Start button
       startLabel.text = "Fight"
       startLabel.name = "fight"
       startLabel.fontSize = 90
       startLabel.fontColor = SKColor.red
       startLabel.zPosition = 1
       startLabel.position = CGPoint(x: self.size.width/2 , y: self.size.height*0.3)
       self.addChild(startLabel)
       print("Displayed Start button")
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //MARK: Change Scene Button
        let touch = touches.first
        let positionInScene = touch!.location(in:self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name{
            if name == "fight" {
                changeScene();
            }
        }
    }
    
    //MARK:Change Scene Function
    func changeScene() {
        let sceneToMoveTo = DuringGameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        print("Scene Changed to Game Scene")
        
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeScene()
    }
 */

}
