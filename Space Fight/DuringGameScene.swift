//
//  DuringGameScene.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 11/7/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//
import Foundation
import SpriteKit
import GameplayKit
var gameScore = 0
var originalxp = 0
var addxp = 0

class DuringGameScene: SKScene,SKPhysicsContactDelegate {
    //MARK:Score things
    
    let scoreLabel = SKLabelNode(fontNamed:"Courier New Bold")
    
    //MARK:Level dude
    
    var levelNumber:Int = 0
    
    //MARK:Lives
    var livesNumber:Int = 3
    let livesLabel = SKLabelNode(fontNamed: "Courier New Bold")
    
    //MARK:player dude setup
    let player = SKSpriteNode(imageNamed: "playerShip")
    let bulletSound = SKAction.playSoundFileNamed("Gun+Silencer.mp3", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion-01.mp3", waitForCompletion: false)
    
    enum gameState{
        case preGame //Before the game start
        case inGame // During the exciting xD game
        case afterGame // The game after the game dllm :D
        
    }
    
    var currentGameState = gameState.inGame
    
    struct PhysicsCatagories {
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Bullet : UInt32 = 0b10 //2
        static let Enemy : UInt32 = 0b100 //4
        
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) // Part 2
    }
    
    func random(min: CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    var gameArea:CGRect
    
    override init(size: CGSize){
        
        let maxAspectRatio:CGFloat = 16.0 / 9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate=self
        //MARK: Background lol
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2 , y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        //MARK:Player dude
        
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/2 * 0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity =  false
        player.physicsBody!.categoryBitMask = PhysicsCatagories.Player
        player.physicsBody!.collisionBitMask = PhysicsCatagories.None
        player.physicsBody!.contactTestBitMask = PhysicsCatagories.Enemy
        self.addChild(player)
        
        //MARK:Score Label
        scoreLabel.text = "0"
        scoreLabel.fontSize = 70
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.2, y: self.size.height*0.9)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        
        //MARK:Lives Label
        livesLabel.text = "lives : 3"
        livesLabel.fontSize = 60
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width*0.76, y: self.size.height*0.9)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        //MARK:Spawn!!! YeahQ
        startNewLevel()
        
        
        
    }
    
    //MARK: Lost live(es) :( GG So sad
    func loseALife() {
        livesNumber -= 1
        livesLabel.text = "Lives : \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0 {
            runGameOver()
        }
        
    }
    
    //MARK:Adding score thingy
    func addScore() {
        
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        print("Game added 1 ,current score is \(gameScore)")
        //MARK: Level
        if gameScore == 5 || gameScore == 10 || gameScore == 30{
            startNewLevel()
            print("Level Increased")
        }
        
    }
    
    //MARK:GameOver thingy :(( GG
    
    func runGameOver() {
        currentGameState = gameState.afterGame
        //MARk: Level Counting
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Bullet"){
            bullet, stop in
            
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy"){
            enemy, stop in
            enemy.removeAllActions()
        }
        print("Game ", "Over")
        //Level System
        //TODO: When can read data, change this to retrieve data from database
        let savedXP:Int = UserDefaults.standard.object(forKey: "xpSaved") as? Int ?? 0
        
        
        
        if  gameScore < 10 && gameScore > 5 {
            addxp += 2
            let currentxp = savedXP + addxp
            print("XP+2")
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
            UserDefaults.standard.set(addxp, forKey: "xpAdded")
            
        } else if gameScore < 5{
            addxp += 1
            print("XP+1")
            let currentxp = savedXP + addxp
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
             UserDefaults.standard.set(addxp, forKey: "xpAdded")
        } else if gameScore > 10 && gameScore < 15 {
            addxp += 3
            print("XP+3")
            let currentxp = savedXP + addxp
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
        } else if gameScore > 15 && gameScore < 20 {
            addxp += 4
            print("XP+4")
            let currentxp = savedXP + addxp
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
        } else if gameScore > 20 && gameScore < 25 {
            addxp += 5
            print("XP+5")
            let currentxp = savedXP + addxp
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
        } else if gameScore > 20 {
            addxp += 6
            print("XP+6")
            let currentxp = savedXP + addxp
            UserDefaults.standard.set(currentxp, forKey: "xpSaved")
        }
        
        
        
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneAction)
        
    }
    
    //MARK:Scene change
    func changeScene() {
        
        let sceneToMoveTo = GameOverScene(size:self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: transition )
        
        
        
    }
    //MARK:
    func didBegin(_ contact: SKPhysicsContact) {
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        }else {
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        if body1.categoryBitMask     == PhysicsCatagories.Player && body2.categoryBitMask    == PhysicsCatagories.Enemy {
            //If the player hit the enemy :D
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            runGameOver()
            print("Game ended ")
        }
        if body1.categoryBitMask == PhysicsCatagories.Bullet && body2.categoryBitMask == PhysicsCatagories.Enemy {
            //If the bullet has hit the enemy
            
            
            
            
            if body2.node != nil {
                if body2.node!.position.y > self.size.height{
                    return
                }else {
                    spawnExplosion(spawnPosition: body2.node!.position)
                }
            }
            addScore()
            spawnExplosion(spawnPosition:body2.node!.position)
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
        }
    }
    //MARK:Explosion animation bombombomb
    func spawnExplosion(spawnPosition: CGPoint){
        let explosion = SKSpriteNode(imageNamed: "explosion")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn,fadeOut , delete])
        explosion.run(explosionSequence)
        
        
        
        
    }
    func startNewLevel() {
        //Enemy spawn sequence bang bang bang
        
        //Level spawn
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        //Level Settings
        switch levelNumber{
        case 1 : levelDuration = 1.2
        case 2 : levelDuration = 1
        case 3 : levelDuration = 0.8
        case 4 : levelDuration = 0.5
        default:
            levelDuration = 0.5
            print("Cannot find level info")
        }
        //Spawn Sequence
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever ,withKey: "spawningEnemies")
    }
    func fireBullet() {
        let bullet = SKSpriteNode(imageNamed:"bullet")
        bullet.name = "Bullet"
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCatagories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCatagories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCatagories.Enemy
        self.addChild(bullet)
        //Bullet Actions
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height , duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        
        //Bullet Sequence boom boom boom boom..bomomombomoamods
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
        
    }
    //Enemy dude
    func spawnEnemy() {
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX);
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        //Setup enemy dude
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.name = "Enemy"
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCatagories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCatagories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCatagories.Player | PhysicsCatagories.Bullet
        self.addChild(enemy)
        
        //Moving enemy skr skr
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let loseAlifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseAlifeAction])
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
        }
        
        //Enemy moving I like to move it move it ,I like to move it move it ,yo
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
        
        
    }
    //MARK: calling Fire Bullet hehe
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentGameState == gameState.inGame {
            fireBullet()
        }
        print("Bullet issued!")
        
        //assert(false)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in:self)
            let previousPointOfTouch = touch.previousLocation(in:self)
            
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            if currentGameState == gameState.inGame {
                player.position.x += amountDragged
            }
            if player.position.x > gameArea.maxX - player.size.width/2 {
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            if player.position.x < gameArea.minX + player.size.width/2 {
                player.position.x = gameArea.minX + player.size.width/2
            }
            
        }
    }
}
