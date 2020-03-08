//
//  GameScene.swift
//  Popcorn
//
//  Created by jerrell on 7/3/20.
//  Copyright © 2020 Hectic Carnival. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    private var lastUpdateTime: TimeInterval = 0
    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?

    override func sceneDidLoad() {
        lastUpdateTime = 0

        // Get label node from scene and store it for use later
        label = childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        spinnyNode = SKShapeNode(
            rectOf: CGSize(width: w, height: w),
            cornerRadius: w * 0.3
        )

        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5

            spinnyNode.run(
                SKAction.repeatForever(
                    SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)
                )
            )
            spinnyNode.run(
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.5),
                    SKAction.fadeOut(withDuration: 0.5),
                    SKAction.removeFromParent(),
                ])
            )
        }
    }

    func touchDown(atPoint pos: CGPoint) {
        // swiftlint:disable:next force_cast
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            addChild(n)
        }
    }

    func touchMoved(toPoint pos: CGPoint) {
        // swiftlint:disable:next force_cast
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            addChild(n)
        }
    }

    func touchUp(atPoint pos: CGPoint) {
        // swiftlint:disable:next force_cast
        if let n = spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            addChild(n)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let label = self.label {
            label.run(SKAction(named: "Pulse")!, withKey: "fadeInOut")
        }

        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with _: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(
        _ touches: Set<UITouch>, with _: UIEvent?
    ) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // Initialize _lastUpdateTime if it has not already been
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let dt = currentTime - lastUpdateTime

        // Update entities
        for entity in entities {
            entity.update(deltaTime: dt)
        }

        lastUpdateTime = currentTime
    }
}
