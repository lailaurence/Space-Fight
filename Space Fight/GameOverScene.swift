//
//  GameOverScene.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 10/7/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//
//Game Over Scene
import Foundation
import SpriteKit
import GameplayKit
import UIKit
import FirebaseDatabase
import Firebase
 var refScore = Database.database().reference().child("High Score")
var hi = 1

class GameOverScene:SKScene {
   
    let restartLabel = SKLabelNode(fontNamed: "Courier New Bold")
    let backLabel = SKLabelNode(fontNamed: "Courier New Bold")
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameoverLabel = SKLabelNode(fontNamed: "Courier New Bold")
        gameoverLabel.text = "Game Over"
        gameoverLabel.fontSize = 150
        gameoverLabel.fontColor = SKColor.white
        gameoverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameoverLabel.zPosition = 1
        self.addChild(gameoverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "playerShip")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        //High score
        let defaults = UserDefaults()
        
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        //Reset high score
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        //Display High Score Label
        let highScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize  = 100
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2 , y: self.size.height*0.45)
        self.addChild(highScoreLabel)
        print ("Displayed high score")
       
        
        
        let restartLabel = SKLabelNode(fontNamed: "Courier New Bold")
        restartLabel.name = "restartlabel"
        restartLabel.text = "Restart"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width/2 , y: self.size.height*0.3)
        self.addChild(restartLabel)
        print("Displayed restarted label")
        
        
        
        let checkRankingLabel = SKLabelNode(fontNamed: "Courier New Bold")
        checkRankingLabel.name = "checkRanking"
        checkRankingLabel.text = "LabelChecking"
     
        /*
        let backLabel = SKLabelNode(fontNamed: "Courier New Bold")
        backLabel.text = "Back to Main Page"
        backLabel.fontSize = 50
        backLabel.fontColor = SKColor.white
        backLabel.zPosition = 1
        backLabel.position = CGPoint(x: 600 , y: 1750)
        self.addChild(backLabel)
        print("Displayed Back Label")
        */
        func addScore() {
            let key = refScore.childByAutoId().key
            let highscoreStore = ["id" : key,
                                  "HighScore": highScoreNumber as Int
                
                ] as [String : Any]
            refScore.child(key!).setValue(highscoreStore)
        }
        addScore()
    
    }
/*
    //Touch "restart button' and redirect
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            if restartLabel.contains(pointOfTouch)
            {
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                print ("Scene changed to Game Scene")
            }
            
            
        //}
 */
       // assert(false)
        changeScenetoGameScene()
    }
    */
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "restartlabel" {
                
                changeScenetoGameScene();
                
            }
            
            
        }
    }
    func changeScenetoGameScene(){
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        print ("Scene changed to Game Scene")
    }
}


