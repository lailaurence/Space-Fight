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
   
    let a = 2
    
    
    let restartLabel = SKLabelNode(fontNamed: "Courier New Bold")
    let backLabel = SKLabelNode(fontNamed: "Courier New Bold")
    override func didMove(to view: SKView) {
        //MARK: Background
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        //MARK: Game over Label
        let gameoverLabel = SKLabelNode(fontNamed: "Courier New Bold")
        gameoverLabel.text = "Game Over"
        gameoverLabel.fontSize = 150
        gameoverLabel.fontColor = SKColor.red
        gameoverLabel.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameoverLabel.zPosition = 1
        self.addChild(gameoverLabel)
        //MARK: Score
        let scoreLabel = SKLabelNode(fontNamed: "playerShip")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 125
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.55)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        
        
        
        //MARKLHigh score
        let defaults = UserDefaults()
        
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        // high score
        if gameScore > highScoreNumber {
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
        }
        //MARk:Display High Score Label
        let highScoreLabel = SKLabelNode(fontNamed: "Courier New Bold")
        highScoreLabel.text = "High Score: \(highScoreNumber)"
        highScoreLabel.fontSize  = 100
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width/2 , y: self.size.height*0.45)
        self.addChild(highScoreLabel)
        print ("Displayed high score")
        
        //MARk: Xp added Label
        let xpAdded:Int = UserDefaults.standard.object(forKey: "xpAdded") as! Int
        let xpAddedLabel = SKLabelNode(fontNamed: "Courier New Bold")
        xpAddedLabel.text = "XP Added : \(xpAdded)"
        xpAddedLabel.fontSize = 70
        xpAddedLabel.fontColor = SKColor.white
        xpAddedLabel.zPosition = 1
        xpAddedLabel.position = CGPoint(x: self.size.width/2 , y: self.size.height*0.38)
        self.addChild(xpAddedLabel)
        print("Displayed XPAdded Label.")
        
        
        
        //MARK:Uploading data to data center
        func uploadData() {
            
            let x = UserDefaults.standard.object(forKey: "usernameSaved")
            guard let y = UIDevice.current.identifierForVendor?.uuidString else { return }
            let key = refScore.childByAutoId().key
            let device = UIDevice.modelName
            let z = UserDefaults.standard.object(forKey: "xpSaved")
            let e = UserDefaults.standard.object(forKey: "emailSaved")
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let highscoreStore = [
                
                "id" : key as Any,
                "Username": x as Any,
                "HighScore": highScoreNumber as Int,
                "XP": z as! Int,
                "Device": device,
                "xpAdded": xpAdded as Any
                
                
                
                
                ] as [String : Any]
            refScore.child(uid).setValue(highscoreStore)
        }
        uploadData()
       
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


public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
