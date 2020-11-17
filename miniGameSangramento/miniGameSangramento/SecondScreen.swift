//
//  PutHeadUpright.swift
//  miniGameSangramento
//
//  Created by Juliana Prado on 09/11/20.
//

import SpriteKit
import GameplayKit

class SecondScreen: SKScene, SKPhysicsContactDelegate {
    
    //Nodes that make up the form of our character
    var head: SKNode!
    var neck1: SKNode!
    var neck2: SKNode!
    var shoulder: SKNode!
    
    //label node
    var labelNode: SKLabelNode!
    
    //Node for collision
    var isFinalPosition: SKNode!
    
    override func didMove(to view: SKView) {
        //inicializes characters' body nodes and their children in their hierarchy
        shoulder = childNode(withName: "shoulder")
        neck1 = shoulder.childNode(withName: "neck1")
        neck2 = neck1.childNode(withName: "neck2")
        head = neck2.childNode(withName: "head")
        
        //inicializing the labelNode with instructions
        if let label = self.childNode(withName: "labelNode") as? SKLabelNode {
            label.verticalAlignmentMode = .top
            label.text = "Ponha a cabeça da pessoa ligeiramente para frente."
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 2
            label.preferredMaxLayoutWidth = 400
        }
        
        //inicializing collision node
        isFinalPosition = childNode(withName: "isFinalPosition")
        
        //set physicsWorld
        self.physicsWorld.contactDelegate = self
        
        //createPhysicsBody for nodes that shall collide
        createPhysicsBody(forNode: head, withColliderType: ColliderType.movableNode)
        createPhysicsBody(forNode: isFinalPosition, withColliderType: ColliderType.finalPosition)
    }
    
    //Allows for the user to lift the characters body, running the animation on the desired node
    func liftHeadTo(_ location: CGPoint) {
      let liftBody = SKAction.reach(to: location, rootNode: neck2, duration: 0.1)
        head.run(liftBody)
    }

    //Upon a touch event, run liftBodyTo action with the tap location as the end position
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            liftHeadTo(location)
        }
    }

    //Check if there was a contact between nodes
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ColliderType.movableNode || contact.bodyB.categoryBitMask == ColliderType.movableNode{
            print("Head is upright")
            if let label = self.childNode(withName: "labelNode") as? SKLabelNode {
                label.verticalAlignmentMode = .top
                label.text = "Correto! Mas lembre: não ponha a cabeça para trás, o sangue pode acabar indo para o estômago!"
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 4
                label.preferredMaxLayoutWidth = 350
            }
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                let goToNextScene = ThirdScreen(size: self.size)
                goToNextScene.scaleMode = SKSceneScaleMode.aspectFill
                let transition = SKTransition.fade(with: SKColor.black, duration: 0.5)
                self.view?.presentScene(goToNextScene, transition: transition)
            }
        }
    }
    
}
//MARK: - SKLabelNode Extension
extension SKLabelNode {
func fitToWidth(maxWidth:CGFloat){
    while frame.size.width >= maxWidth {
        fontSize-=1.0
    }
}

func fitToHeight(maxHeight:CGFloat){
    while frame.size.height >= maxHeight {
        fontSize-=1.0
    }

}
}
