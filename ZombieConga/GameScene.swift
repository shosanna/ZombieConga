//
//  GameScene.swift
//  ZombieConga
//
//  Created by Zuzana Dostalova on 17/03/15.
//  Copyright (c) 2015 Zuzana Dostalova. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    // creating zombie
    var zombie = SKSpriteNode(imageNamed: "zombie1")
    let zombieMovePointsPerSec: CGFloat = 480
    var velocity = CGPointZero
    
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    override func didMoveToView(view: SKView) {
        // adding background
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        // default is 0, so if it is negative number it always will be drawn first
        background.zPosition = -1
        
        // every sprite needs to be added to the scene
        addChild(background)
        
        // adding zombie
        zombie.position = CGPoint(x: 400, y: 400)
        zombie.name = "zombie"
        addChild(zombie)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // Updating the delta
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        
        lastUpdateTime = currentTime
        
        moveSprite(zombie, velocity: CGPoint(x: zombieMovePointsPerSec, y: 0))
    }
    
    // This function calculates the right amount of steps for each frame
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        // velocity is a vector representing a direction and a length
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        
    }
}
