//
//  GameScene.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 12/31/22.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    let slider = UISlider(frame: CGRect(x:100 , y: 750, width: 200, height: 20))
    var waitTime: CGFloat = 3
    var ball = SKShapeNode(circleOfRadius: 40)
    var num: CGFloat = 1
    
    override func didMove(to view: SKView) {
        ball.speed = num
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        backgroundColor = SKColor.systemBlue
        ball.fillColor = SKColor.systemOrange
        self.addChild(ball)
        loadSlider()
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.backgroundColor = self.getRandomColor()}, SKAction.wait(forDuration: 5)]
        )))
            
        
    }
    
    private func loadSlider() {
        slider.maximumValue = 2
        slider.minimumValue = 0
        view?.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderAction(_: )), for: .valueChanged)
         }
    @objc func sliderAction(_ sender: UISlider) {
        num = CGFloat(sender.value)
        print(num)
    }
    
    
    func getRandomColor() -> SKColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return SKColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    func goToCorner(ball: SKShapeNode, num: CGFloat) {
        let spacer = ball.frame.width * 0.70
        let moveToUpperCorner = SKAction.move(to: .init(x: (frame.maxX - spacer),
                                                        y: (frame.minY + spacer)),
                                              duration: TimeInterval(3))
        
        let moveToLowerCorner = SKAction.move(to: .init(x: (frame.minX + spacer),
                                                        y: (frame.maxY - spacer)),
                                              duration: TimeInterval(3))
        
        let sqnc = SKAction.sequence([moveToLowerCorner, moveToUpperCorner])
        ball.run(SKAction.repeatForever(sqnc), withKey: "key")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let action = self.ball.action(forKey: "key") {
            
            action.speed = self.num
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.count == 1 {
            goToCorner(ball: ball, num: num)
            SKAction.run {
                self.goToCorner(ball: self.ball, num: self.num)
            }
        }
        
    }
}


