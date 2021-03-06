//
//  GameScene.swift
//  DonutsBucket
//
//  Created by 屋代昌也 on 2015/06/20.
//  Copyright (c) 2015年 屋代昌也. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    enum PhysicsCategories : UInt32 {
        case None     = 0x0
        case All      = 0xFFFF_FFFF
        case Donuts   = 0b0000_0001
        case Player   = 0b0000_0010
        case Outline  = 0b0000_0100
    }

    let playerNode = SKSpriteNode(imageNamed: "Spaceship")
    let scoreNode  = SKLabelNode(text: "score: 0")
    var score: Int = 0 {
        didSet {
            self.scoreNode.text = "score: \(score)"
        }
    }

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.size = view.bounds.size
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)


        playerNode.position = CGPointMake(CGRectGetMidX(self.frame), 100)
        playerNode.xScale = 0.25
        playerNode.yScale = 0.25
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: (playerNode.frame.size.width / 2))
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        playerNode.physicsBody?.categoryBitMask = PhysicsCategories.Player.rawValue
        playerNode.physicsBody?.affectedByGravity = false
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.collisionBitMask = PhysicsCategories.Donuts.rawValue | PhysicsCategories.Player.rawValue
        playerNode.physicsBody?.contactTestBitMask = PhysicsCategories.Donuts.rawValue | PhysicsCategories.Player.rawValue

        self.addChild(playerNode)

        self.score = 0
        self.scoreNode.fontSize = 24
        self.scoreNode.position = CGPointMake(
            CGRectGetMidX(self.frame),
            CGRectGetMaxY(self.frame) - self.scoreNode.frame.height
        )
        self.addChild(scoreNode)

        let path = NSBundle.mainBundle().pathForResource("DonutsParticle", ofType: "sks")
        let spriteDonuts: SKEmitterNode = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode

        spriteDonuts.targetNode = self.scene
        spriteDonuts.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 50 )
        spriteDonuts.xScale = 1
        spriteDonuts.yScale = 1
        spriteDonuts.fieldBitMask = PhysicsCategories.Donuts.rawValue

        spriteDonuts.physicsBody = SKPhysicsBody(circleOfRadius: (64 / 2))
        spriteDonuts.physicsBody?.affectedByGravity = false
        spriteDonuts.physicsBody?.allowsRotation = false
        spriteDonuts.particleAction = DonutsAction()
        println("moge")
//        spriteDonuts.physicsBody?.usesPreciseCollisionDetection = true
//        spriteDonuts.physicsBody?.categoryBitMask = PhysicsCategories.Donuts.rawValue
//        spriteDonuts.physicsBody?.collisionBitMask = PhysicsCategories.Donuts.rawValue | PhysicsCategories.Player.rawValue
//        spriteDonuts.physicsBody?.contactTestBitMask = PhysicsCategories.Donuts.rawValue | PhysicsCategories.Player.rawValue
        self.addChild(spriteDonuts)

    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */

        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            /*
            let sprite = SKSpriteNode(imageNamed:"Spaceship")

            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location

            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

            sprite.runAction(SKAction.repeatActionForever(action))

            self.addChild(sprite)
*/
        }
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            self.playerNode.position = CGPointMake(location.x, self.playerNode.position.y)
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //self.playerNode.position = CGPointMake(self.playerNode.position.x, 100)
    }
}

extension GameScene : SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        println(contact)
    }

}
