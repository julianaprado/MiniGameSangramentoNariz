//
//  GlobalFunctions.swift
//  miniGameSangramento
//
//  Created by Juliana Prado on 09/11/20.
//

import SpriteKit


//BitMask for different nodes
struct ColliderType{
    static let finalPosition: UInt32 = 1
    static let movableNode: UInt32 = 2
}

func createPhysicsBody(forNode nodeName: SKNode, withColliderType colliderType: UInt32){
    if nodeName.name == "isFinalPosition"{
        nodeName.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
    } else{
        nodeName.physicsBody = SKPhysicsBody(rectangleOf: nodeName.frame.size)
    }
    
    nodeName.physicsBody?.affectedByGravity = false
    nodeName.physicsBody?.isDynamic = true
    nodeName.physicsBody?.categoryBitMask = colliderType
    nodeName.physicsBody?.collisionBitMask = 0
    
    if colliderType == ColliderType.movableNode{
        nodeName.physicsBody?.contactTestBitMask = ColliderType.finalPosition
    }
    else{
        nodeName.physicsBody?.contactTestBitMask = ColliderType.movableNode
    }
}
