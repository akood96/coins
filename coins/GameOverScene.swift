//
//  picCoins.swift
//  coins
//
//  Created by akood on 6/24/19.
//  Copyright © 2019 akood. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameOverScene: SKScene, GKGameCenterControllerDelegate  {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    var dateComponents = DateComponents()
   
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        
        
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 3  // Tuesday
        dateComponents.hour = 14    // 14:00 hours
        
        let timer = Timer(fireAt: dateComponents, interval: 0, target: self, selector: #selector(resetHighscore), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
        
        
        saveHighscore(number: highScore)
        
        
        
        //Sets the integer value for the key "highscore" to be equal to 0
        //UserDefaults.standard.set(0, forKey: "highScoreSaved")
        //Synchronizes the NSUserDefaults
        //UserDefaults.standard.synchronize()
        
        let gameOverLabel = SKLabelNode(fontNamed: "The Bold Font")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 80
        gameOverLabel.fontColor = SKColor.black
        gameOverLabel.position = CGPoint(x: self.frame.size.width * 0, y: self.frame.size.height * 0.2)
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let scoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        scoreLabel.text = "\(gameScore)"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * 0.1)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        //let defaults = UserDefaults()
        //var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if gameScore > highScore {
            highScore = gameScore
            UserDefaults.standard.set(highScore, forKey: "highScoreSaved")
        }
        
        let highScoreLabel = SKLabelNode(fontNamed: "The Bold Font")
        highScoreLabel.text = "Highest Score: \(highScore)"
        highScoreLabel.fontSize = 60
        highScoreLabel.fontColor = SKColor.black
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * 0)
        self.addChild(highScoreLabel)
        
        restartLabel.text = "Restart"
        restartLabel.fontSize = 60
        restartLabel.fontColor = SKColor.red
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.1)
        self.addChild(restartLabel)
        
        
        gobackLabel.text = "Home"
        gobackLabel.fontSize = 60
        gobackLabel.fontColor = SKColor.black
        gobackLabel.zPosition = 1
        gobackLabel.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.2)
        self.addChild(gobackLabel)
        
        gameLabel.text = "LeaderBoard"
        gameLabel.fontSize = 60
        gameLabel.fontColor = SKColor.purple
        gameLabel.zPosition = 1
        gameLabel.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * -0.3)
        self.addChild(gameLabel)
        
    }
    
    func resetHighscore(){
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: "Highscore")
        defaults.setValue(0, forKey: "Highscore")
        defaults.synchronize()
        
    }
    
    func saveHighscore(number : Int) {
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReport = GKScore(leaderboardIdentifier: "Highest")
            
            scoreReport.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReport]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let PointIToched = touch.location(in: self)
            
            if restartLabel.contains(PointIToched){
        
        let waitToChangeScene = SKAction.wait(forDuration: 0)
        let changeScene = SKAction.run {
            let sceneToMoveTo = SKScene(fileNamed: "GameScene")!
            sceneToMoveTo.scaleMode = self.scaleMode
            let sceneTransition = SKTransition.fade(withDuration: 0.5)
            self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        }
        let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
        self.run(sceneChangeSequence)
            }
        }
        
        for touch: AnyObject in touches{
            let PointIToched = touch.location(in: self)
            
            if gobackLabel.contains(PointIToched){

                let waitToChangeScene = SKAction.wait(forDuration: 0)
                let changeScene = SKAction.run {
                    let sceneToMoveTo = SKScene(fileNamed: "MainScene")!
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let sceneTransition = SKTransition.fade(withDuration: 0.5)
                    self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                }
                let sceneChangeSequence = SKAction.sequence([waitToChangeScene, changeScene])
                self.run(sceneChangeSequence)
            }
        }
        
        for touch: AnyObject in touches{
            let PointITouched = touch.location(in: self)
            
            if gameLabel.contains(PointITouched){
                
                let vc = self.view?.window?.rootViewController
                let gc = GKGameCenterViewController()
                
                gc.viewState = GKGameCenterViewControllerState.leaderboards
                gc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                
                vc!.present(gc, animated: true, completion: nil)
                
                
                /*let viewController = self.view?.window?.rootViewController
                
                let gcvc = GKGameCenterViewController()
                
                gcvc.gameCenterDelegate = self as? GKGameCenterControllerDelegate
                
                viewController?.present(gcvc, animated: true, completion: nil)*/
            }
        }
    
            
        }
    
}

