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
        
        moveSprite(zombie, velocity: velocity)
        boundsCheckZombie()
        rotateSprite(zombie, direction: velocity)
    }
    
    // This function calculates the right amount of steps for each frame
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        // velocity is a vector representing a direction and a length
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    // Only calculates the right velocity
    func moveZombieToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
        velocity = CGPoint(x: direction.x * zombieMovePointsPerSec, y: direction.y * zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        moveZombieToward(touchLocation)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        sceneTouched(touchLocation)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        sceneTouched(touchLocation)
    }
    
    // Check if zombie is not outside the playable area and if he is, change his direction
    func boundsCheckZombie() {
        let bottomLeft = CGPointZero
        let topRight = CGPoint(x: size.width, y: size.height)
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint) {
        sprite.zRotation = CGFloat(atan2(Double(direction.y), Double(direction.x)))
    }
}
