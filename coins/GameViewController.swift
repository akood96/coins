//
//  GameViewController.swift
//  coins
//
//  Created by akood on 6/13/19.
//  Copyright © 2019 akood. All rights reserved.
//   app ID: ca-app-pub-6588245967218697~5726485775
// ca-app-pub-3940256099942544/4411468910
// Unit ID: ca-app-pub-6588245967218697/1185493586

import UIKit
import SpriteKit
import GameplayKit
import UserNotifications
import GoogleMobileAds
import GameKit



class GameViewController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
   
    var localPlayer: GKLocalPlayer = GKLocalPlayer.local
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
                
            }
            else {
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
        
        
       interstitial = GADInterstitial(adUnitID: "ca-app-pub-5164537640898986/3060531622")
        
        let request = GADRequest()
        interstitial.load(request)
    
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showAd), name: NSNotification.Name("notification"), object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    
    func createAd() -> GADInterstitial {
        let inter = GADInterstitial(adUnitID: "ca-app-pub-5164537640898986/3060531622")
        
        inter.load(GADRequest())
        return inter
        
    }
    
    @objc func showAd()  {
        if(interstitial.isReady) {
            
            interstitial.present(fromRootViewController: self)
            interstitial = createAd()
        } else {
            print(" ")
        }

    }
    
    
    }
