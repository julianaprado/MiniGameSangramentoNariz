//
//  GameScene.swift
//  miniGameSangramento
//
//  Created by Juliana Prado on 04/11/20.
//

import SpriteKit
import GameplayKit

class FirstScreen: SKScene, SKPhysicsContactDelegate {

    //Node that make up the form of our character
    var head: SKNode!
    var neck: SKNode!
    var shoulder: SKNode!
    var torso: SKNode!

    //label node
    var labelNode: SKLabelNode!
    
    //Node for collision
    var isFinalPosition: SKNode!
    
    override func didMove(to view: SKView) {
        
        //inicializes character's body nodes and their children in their hierarchy
        torso = childNode(withName: "torso")
        shoulder = torso.childNode(withName: "shoulder")
        neck = shoulder.childNode(withName: "neck")
        head = neck.childNode(withName: "head")
        
        //inicializing collision node
        isFinalPosition = childNode(withName: "isFinalPosition")
        
        //inicializing the labelNode with instructions
        if let label = self.childNode(withName: "labelNode") as? SKLabelNode {
            label.verticalAlignmentMode = .top
            label.text = "Ponha a pessoa na posição vertical."
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 2
            label.preferredMaxLayoutWidth = 300
             }
        
        //set physicsWorld
        self.physicsWorld.contactDelegate = self
        
        //createPhysicsBody for nodes that shall collide
        createPhysicsBody(forNode: neck, withColliderType: ColliderType.movableNode)
        createPhysicsBody(forNode: isFinalPosition, withColliderType: ColliderType.finalPosition)
    }
    
    //Allows for the user to lift the characters body, running the animation on the desired node
    func liftBodyTo(_ location: CGPoint) {
        let liftBody = SKAction.reach(to: location, rootNode: shoulder, duration: 0.1)
        neck.run(liftBody)
    }

    //Upon a touch event, run liftBodyTo action with the drag location as the end position
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            liftBodyTo(location)
        }
    }

    //Check if there was a contact between nodes
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ColliderType.movableNode || contact.bodyB.categoryBitMask == ColliderType.movableNode{
            if let label = self.childNode(withName: "labelNode") as? SKLabelNode {
                label.verticalAlignmentMode = .top
                label.text = "Isso!"
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 2
                label.preferredMaxLayoutWidth = 300
            }
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                let newScene = SecondScreen(fileNamed: "SecondScreen")!
                newScene.scaleMode = .aspectFill
                let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
                self.view?.presentScene(newScene, transition: transition)
            }
        }
    }
}

