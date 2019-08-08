//
//  GameScene.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 7/7/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//

import SpriteKit
import GameplayKit
import FirebaseUI
import FirebaseAuth
import Firebase
import UIKit
//Score things
class GameScene: SKScene {


    
    
    
    
    
    
    

    let startLabel = SKLabelNode(fontNamed:"Courier New Bold")
    
    override func didMove(to view: SKView) {
        //background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        
        //MARK: Level System
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
