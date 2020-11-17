//
//  SegurarNariz.swift
//  miniGameSangramento
//
//  Created by Juliana Prado on 10/11/20.
//

import Foundation
import SpriteKit

class ThirdScreen: SKScene{
    
    //Progressbar
    let progressBar = ProgressBarSprite(emptyImageName: "emptyImage",filledImageName: "filledImage")
    
    //Nose node
    var nose: SKSpriteNode!
    
    //Current node touched
    private var currentNode: SKNode?
    
    //Default position of the current touched node
    private var defaultPosition: CGPoint?
    
    //Checks if user is pinching
    var pinching = false
    var pinchingCount = 0
    var secondsPassed = 0
    var timer = Timer()
    var totalTime = 10
    
    //Pinch recognizer
    var pinchRec: UIPinchGestureRecognizer!
    
    override func didMove(to view: SKView) {

        //Setting up nose asset on screen
        let nose = SKSpriteNode(imageNamed: "narizcolorido")
        nose.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        nose.setScale(0.75)
        nose.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(nose)
        
        //Setting up the pinch recognizer
        pinchRec = UIPinchGestureRecognizer()
        pinchRec.addTarget(self, action: #selector(ThirdScreen.pinched))
        self.view!.addGestureRecognizer(pinchRec)
        
        progressBar.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 300)
        self.addChild(progressBar)
    }
    
    //Check if the touch the user made was on a node and gets info of the node
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            
            for node in touchedNodes.reversed(){
                if node == nose{
                    print("Entrou no if")
                    self.defaultPosition = node.position
                    self.currentNode = node
                }
            }
        }
    }
    
    //Called everytime to update variables values
    override func update(_ currentTime: TimeInterval) {
        if pinching == true && currentNode == nose{
            print("Pinched nose!")
            if pinchingCount < totalTime {
                secondsPassed += 1
                progressBar.setXProgress(xProgress: -0.1)
             
            } else{
                
            }
        }
    }
    
    //Check if the touched ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode?.position = self.defaultPosition ?? CGPoint(x: 0, y: 0)
        self.currentNode = nil
        print("Stopped pinching")
    }
    
    @objc func pinched(){
        pinching = true
    }
    
}
