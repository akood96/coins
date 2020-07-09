//
//  GameScene.swift
//  coins
//
//  Created by akood on 6/13/19.
//  Copyright © 2019 akood. All rights reserved.
//

import SpriteKit
import GameplayKit



struct bitMask {
   static let Coin: UInt32 = 0x1 << 1
    static let Side: UInt32 = 0x1 << 2
    static let Other: UInt32 = 0x1 << 3
    static let Side2: UInt32 = 0x1 << 4
    static let Side3: UInt32 = 0x1 << 5
}

class GameScene: SKScene, SKPhysicsContactDelegate {

  
    
    let coinSound: SKAction = SKAction.playSoundFileNamed("coin.mp3", waitForCompletion: false)
    let coinAffect: SKAction = SKAction.playSoundFileNamed("coin2.mp3", waitForCompletion: false)
   
    let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    let tapToStartLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "The Bold Font")
    var cup:SKSpriteNode!
    var side:SKSpriteNode!
    var side2:SKSpriteNode!
    var side3:SKSpriteNode!
    var top:SKSpriteNode!
    
    var Coinstimer = Timer()
    var otherCoins = Timer()
    
    var coinTimer:Timer!
    
    
    var currentGameState = gameState.inGame

    override func didMove(to view: SKView) {

        gameScore = 0
        ballMovementSpeed = 3.2
        
        
        physicsWorld.contactDelegate = self
        
        backgroundColor = UIColor.white
        
        
        //top = SKSpriteNode(imageNamed: "side")
        //top.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.25)
        //top.size = CGSize(width: self.size.width * 0.02, height: self.size.height * 0.3)
        //self.addChild(top)
        
         cup = SKSpriteNode(imageNamed: "cup")
        cup.zPosition = 1.0
        cup.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.31)
        cup.size = CGSize(width: self.size.width * 0.3, height: self.size.height * 0.15)
        self.addChild(cup)
        
        side = SKSpriteNode(imageNamed: "side")
        side.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.3)
        side.size = CGSize(width: self.size.width * 0.05, height: self.size.height * 0.10)
        side.physicsBody = SKPhysicsBody(rectangleOf: side.size)
        side.physicsBody?.affectedByGravity = false
        side.physicsBody?.categoryBitMask = bitMask.Side
        side.physicsBody?.collisionBitMask = bitMask.Coin | bitMask.Other
        side.physicsBody?.contactTestBitMask = bitMask.Coin | bitMask.Other
        side.physicsBody?.isDynamic = false
        side.name = "side"
        self.addChild(side)
        
        side2 = SKSpriteNode(imageNamed: "side-1")
        side2.position = CGPoint(x: self.frame.size.width * 0.06, y: frame.size.height * -0.3)
        side2.size = CGSize(width: self.size.width * 0.12, height: self.size.height * 0.05)
        side2.physicsBody = SKPhysicsBody(rectangleOf: side2.size)
        side2.physicsBody?.affectedByGravity = false
        side2.physicsBody?.categoryBitMask = bitMask.Side2
        side2.physicsBody?.collisionBitMask = bitMask.Coin
        side2.physicsBody?.contactTestBitMask = bitMask.Coin
        side2.physicsBody?.isDynamic = false
        side2.name = "side-1"
        self.addChild(side2)
        
        side3 = SKSpriteNode(imageNamed: "side-1")
        side3.position = CGPoint(x: self.frame.size.width * -0.06, y: frame.size.height * -0.3)
        side3.size = CGSize(width: self.size.width * 0.12, height: self.size.height * 0.05)
        side3.physicsBody = SKPhysicsBody(rectangleOf: side3.size)
        side3.physicsBody?.affectedByGravity = false
        side3.physicsBody?.categoryBitMask = bitMask.Side3
        side3.physicsBody?.collisionBitMask = bitMask.Coin
        side3.physicsBody?.contactTestBitMask = bitMask.Coin
        side3.physicsBody?.isDynamic = false
        side3.name = "side-1"
        self.addChild(side3)
        
        
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = SKColor.green
        scoreLabel.position = CGPoint(x: self.size.width * -0.38, y: self.size.height * 0.2)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        livesLabel.text = "3"
        livesLabel.fontSize = 50
        livesLabel.fontColor = SKColor.red
        livesLabel.position = CGPoint(x: self.size.width * 0.38, y: self.size.height * 0.2)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        
       
        //coinTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(createCoin), userInfo: nil, repeats: true)
        
        /*let randomFunc = [self.createcoinRepeat, self.otherOne]
        
        let randomResult = Int(arc4random_uniform(UInt32(randomFunc.count)))
        return randomFunc[randomResult]()*/
        createcoinRepeat()
        
        
    }
    
    func loseAlife(){
        livesNumber -= 1
        livesLabel.text = "\(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0{
            runGameOver()
        }
    }
    
    func addScore(){
       gameScore += 1
        scoreLabel.text = "\(gameScore)"
        
        switch gameScore {
        case 5: ballMovementSpeed = 3.1
        case 10: ballMovementSpeed = 3
        case 15: ballMovementSpeed = 2.9
        case 25: ballMovementSpeed = 2.8
        case 35: ballMovementSpeed = 2.7
        case 45: ballMovementSpeed = 2.6
        case 55: ballMovementSpeed = 2.5
        case 65: ballMovementSpeed = 2.4
        case 75: ballMovementSpeed = 2.3
        case 85: ballMovementSpeed = 2.2
        case 95: ballMovementSpeed = 2.1
        case 100: ballMovementSpeed = 2
        default: print(" ")
        }
    }
    
    func runGameOver(){
        
        Coinstimer.invalidate()
        currentGameState = .afterGame
        cup.removeAllActions()
     
        NotificationCenter.default.post(name: NSNotification.Name("notification"), object: nil)
        
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeScene = SKAction.run {
            let sceneToMoveTo = SKScene(fileNamed: "GameOverScene")!
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        }
        let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
        self.run(sceneChangeSequence)
    }
    
    //11
    func collision(between iScoin: SKNode, object: SKNode){
        if object.name == "iScoin" {
            collisionBoth(iScoin: iScoin)
        }else if object.name == "side" {
            collisionBoth(iScoin: iScoin)
        }
    }
    //12
    func makeOther(between othersOne: SKNode, object: SKNode){
    
        if object.name == "otherone" {
            collisionOther(othersOne: othersOne)
        }else if object.name == "side" {
            collisionOther(othersOne: othersOne)
        }
    }
    
    //13
    func sideTwo(between iScoin: SKNode, object: SKNode) {
        
        if object.name == "iScoin" {
            collisionSide2(iScoin: iScoin)
        }else if object.name == "side-1" {
            collisionSide2(iScoin: iScoin)
        }
    }
    
    //1
    func collisionBoth(iScoin: SKNode) {
       
        //print("ok")
        addScore()
        run(coinSound)
        iScoin.removeFromParent()
    }
    //2
    func collisionOther(othersOne: SKNode)  {
        //print("ah")
        run(coinAffect)
      othersOne.removeFromParent()
        runGameOver()
    }
    
    //3
    func collisionSide2(iScoin: SKNode){
        //print("1")
        loseAlife()
        iScoin.removeFromParent()
        iScoin.removeAllActions()
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "iScoin" {
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }else if contact.bodyB.node?.name == "iScoin" {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
        if contact.bodyA.node?.name == "otherone" {
            makeOther(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }else if contact.bodyB.node?.name == "otherone" {
            makeOther(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
        if contact.bodyA.node?.name == "iScoin" {
            sideTwo(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }else if contact.bodyB.node?.name == "iScoin" {
            sideTwo(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
        
    }

    
    func createcoinRepeat() {
        let iScoin = TheCoin()
        let othersOne = FakeCoins()
        
        let randomPosition = GKRandomDistribution(lowestValue: -250, highestValue: 250)
        let position = CGFloat(randomPosition.nextInt())
        
        //let downRandom = GKRandomDistribution(lowestValue: 400, highestValue: 800)
        //let bosition = CGFloat(downRandom.nextInt())
        
        let RandomPosNumr = arc4random() % 2
        
        switch RandomPosNumr {
        case 0:
            iScoin.position.y = self.size.height*1
            iScoin.position.x = position
            self.addChild(iScoin)
            break
        case 1:
            othersOne.position.y = self.size.height*1
            othersOne.position.x = position
            self.addChild(othersOne)
            break
        default:
            break
        }
    
        
        othersOne.name = "otherone"
        let othrCoin = SKAction.moveTo(y: frame.size.height * -0.5, duration: ballMovementSpeed)
        let othr1Coin = SKAction.removeFromParent()
        let coin$equence = SKAction.sequence([othrCoin, othr1Coin])
        othersOne.run(coin$equence)

        iScoin.name = "iScoin"
        let moveCoin = SKAction.moveTo(y: frame.size.height * -0.5, duration: ballMovementSpeed)
         let deleteCoin = SKAction.removeFromParent()
        let loseAlifeAction = SKAction.run(loseAlife)
        let coinSequence = SKAction.sequence([moveCoin, deleteCoin, loseAlifeAction])
        iScoin.run(coinSequence)
        
        //iScoin.run(SKAction.moveTo(y: -400, duration: 2))
        Coinstimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block:{_ in
            self.createcoinRepeat()
        })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            //if currentGameState == .inGame{
            cup.position.x += amountDragged
            side.position.x += amountDragged
            side2.position.x += amountDragged
            side3.position.x += amountDragged
            //top.position.x += amountDragged
            //}
            /*if cup.position.x > CGRectGetMaxX(gameArea){
             cup.position.x = CGRectGetMaxX(gameArea)
             }
             if cup.position.x < CGRectGetMinX(gameArea){
             cup.position.x = CGRectGetMinX(gameArea)
             }*/
            
        }
        
    }
    
    
            
    
        }


