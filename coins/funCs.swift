//
//  funCs.swift
//  coins
//
//  Created by akood on 7/15/19.
//  Copyright © 2019 akood. All rights reserved.
//

import Foundation
import SpriteKit



var gameScore: Int = 0


var highScore = UserDefaults.standard.integer(forKey: "highScoreSaved")

var ballMovementSpeed: TimeInterval = 3.2

var Playlabel = SKLabelNode(fontNamed: "The Bold Font")

var restartLabel = SKLabelNode(fontNamed: "The Bold Font")

var gobackLabel = SKLabelNode(fontNamed: "The Bold Font")

var howtoLabel = SKLabelNode(fontNamed: "The Bold Font")

var shareappLabel = SKLabelNode(fontNamed: "The Bold Font")

var gameLabel = SKLabelNode(fontNamed: "The Bold Font")
