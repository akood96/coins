//
//  MainScene.swift
//  coins
//
//  Created by akood on 7/21/19.
//  Copyright © 2019 akood. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class MainScene: SKScene {
   
    
    var jar:SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
       
        
        
        
        jar = SKSpriteNode(imageNamed: "jar")
        jar.zPosition = 1.0
        jar.position = CGPoint(x: self.frame.size.width * 0, y: frame.size.height * 0.25)
        jar.size = CGSize(width: self.size.width * 0.25, height: self.size.height * 0.2)
        self.addChild(jar)
        
        let Mainscene = SKLabelNode(fontNamed: "The Bold Font")
        Mainscene.text = "Coin Jar"
        Mainscene.fontSize = 80
        Mainscene.fontColor = SKColor.cyan
        Mainscene.position = CGPoint(x: self.frame.size.width * 0, y: self.frame.size.height * -0.0)
        Mainscene.zPosition = 1
        self.addChild(Mainscene)
        
        Playlabel.text = "Play"
        Playlabel.fontSize = 60
        Playlabel.fontColor = SKColor.red
        Playlabel.position = CGPoint(x: self.frame.size.width * 0, y: self.frame.size.height * -0.13)
        Playlabel.zPosition = 1
        self.addChild(Playlabel)
        
        howtoLabel.text = "How  to  Play?"
        howtoLabel.fontSize = 55
        howtoLabel.fontColor = SKColor.red
        howtoLabel.position = CGPoint(x: self.frame.size.width * 0, y: self.frame.size.height * -0.2)
        howtoLabel.zPosition = 1
        self.addChild(howtoLabel)
        
        
        shareappLabel.text = "Share  App"
        shareappLabel.fontSize = 60
        shareappLabel.fontColor = SKColor.blue
        shareappLabel.position = CGPoint(x: self.frame.size.width * 0, y: self.frame.size.height * -0.3)
        shareappLabel.zPosition = 1
        self.addChild(shareappLabel)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let PointIToched = touch.location(in: self)
            
            if Playlabel.contains(PointIToched){
                
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
            
            if howtoLabel.contains(PointIToched){
                
                let waitToChangeScene = SKAction.wait(forDuration: 0)
                let changeScene = SKAction.run {
                    let sceneToMoveTo = SKScene(fileNamed: "howTo")!
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
            
            if shareappLabel.contains(PointIToched){
                share(on: self, text: "Try this Game!  https://apps.apple.com/us/app/coin-jar-game/id1473715043", image: UIImage(named: "60") , exculdeActivityTypes: [])

        }
            
        }
    }
    
    func share(on scene: SKScene, text: String, image: UIImage?, exculdeActivityTypes: [UIActivity.ActivityType]
        ) {
        
        guard let image = UIImage(named: "60") else {return}
        
        let shareItems = [ text, image ] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = scene.view
        activityViewController.excludedActivityTypes = exculdeActivityTypes
        scene.view?.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
  
}
