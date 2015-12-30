//
//  TriAngleView.swift
//  AnimationDemo
//
//  Created by liuk on 15/12/21.
//  Copyright © 2015年 Kai Liu. All rights reserved.
//

import UIKit

class TriangleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        self.backgroundColor = UIColor.clearColor()
    }
    func initViews(){
        self.checkAnimation()
    }
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.init(colorLiteralRed: 0.569, green: 0.875, blue: 0.945, alpha: 1).CGColor)
        CGContextSetStrokeColorWithColor(context, UIColor.init(colorLiteralRed: 0.569, green: 0.875, blue: 0.945, alpha: 1).CGColor)
        let pointArray: [CGPoint] = [CGPointMake(0, self.height), CGPointMake(self.width, 0), CGPointMake(self.width, self.height)]
        CGContextAddLines(context, pointArray, 3)
        CGContextClosePath(context)
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
    func checkAnimation(){
        let checkShapeLayer = CAShapeLayer.init()
        let checkBezier = UIBezierPath.init()
        let rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2)

//        let rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2)
        checkBezier.moveToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9 + 12, rectInCircle.origin.y + rectInCircle.size.height*2/3 + 4))
        checkBezier.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3 + 12,rectInCircle.origin.y + rectInCircle.size.height*9/10 + 4))
        checkBezier.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10 + 12, rectInCircle.origin.y + rectInCircle.size.height*2/10 + 4))
        
        checkShapeLayer.path = checkBezier.CGPath
        
        //两端起始点样式
        checkShapeLayer.lineCap = kCALineCapRound
        
        //折角样式
        checkShapeLayer.lineJoin = kCALineJoinRound
        checkShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        checkShapeLayer.fillColor = UIColor.clearColor().CGColor
        checkShapeLayer.lineWidth = 3
        self.layer.addSublayer(checkShapeLayer)
        
        let checkAnimaton = CABasicAnimation.init(keyPath: "strokeEnd")
        checkAnimaton.duration = 0.3
        checkAnimaton.fromValue = 0
        checkAnimaton.toValue = 1
        
        checkShapeLayer.addAnimation(checkAnimaton, forKey: "checkAnimation")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
