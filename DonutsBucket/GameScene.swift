//
//  GameScene.swift
//  DonutsBucket
//
//  Created by 屋代昌也 on 2015/06/20.
//  Copyright (c) 2015年 屋代昌也. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let playerNode = SKSpriteNode(imageNamed: "Spaceship")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        playerNode.position = CGPointMake(CGRectGetMidX(self.frame), 100)
        playerNode.xScale = 0.25
        playerNode.yScale = 0.25
        
        self.addChild(playerNode)

        let path = NSBundle.mainBundle().pathForResource("DonutsParticle", ofType: "sks")
        let spriteDonuts: SKEmitterNode = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        
        spriteDonuts.targetNode = self.scene
        spriteDonuts.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 50 )
        spriteDonuts.xScale = 1
        spriteDonuts.yScale = 1
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
    }
}
