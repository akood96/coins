//
//  FakeCoins.swift
//  coins
//
//  Created by akood on 7/22/19.
//  Copyright © 2019 akood. All rights reserved.
//

import Foundation
import SpriteKit

class FakeCoins: SKSpriteNode {
    
    enum colorType{
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case eleven
        
    }
    
    let coinRandomOrder:[colorType] = [
        .one,
        .two,
        .three,
        .four,
        .five,
        .six,
        .seven,
        .eight,
        .nine,
        .ten,
        .eleven
    ]
    
    
    let type: colorType
    
    init() {
        
        let randomTypeIndex = Int(arc4random()%11)
        self.type = coinRandomOrder[randomTypeIndex]
        
        let Fake = SKTexture(imageNamed: "other_\(self.type)")
        
        super.init(texture: Fake, color: SKColor.clear, size: CGSize(width: 95, height: 95))
        
        //sprite.size = CGSize(width: 50, height: 50)
        //addChild(sprite)
        
        //physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        //coin.setScale(1)
        physicsBody = SKPhysicsBody(circleOfRadius: 25)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = bitMask.Other
        physicsBody?.contactTestBitMask = bitMask.Side
        physicsBody?.collisionBitMask = 0
        physicsBody?.isDynamic = true
        //coin.name = "iScoin"
        /*let moveCoin = SKAction.moveTo(y: -400, duration: 2)
         let deleteCoin = SKAction.removeFromParent()
         //let loseAlifeAction = SKAction.run(loseAlife)
         let coinSequence = SKAction.sequence([moveCoin, deleteCoin])
         sprite.run(coinSequence)*/
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
}
}
