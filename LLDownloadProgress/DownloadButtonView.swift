//
//  DownloadButtonView.swift
//  AnimationDemo
//
//  Created by liuk on 15/10/29.
//  Copyright © 2015年 Kai Liu. All rights reserved.
//

import UIKit
let kProgressBarHeight: CGFloat = 50
let kProgressBarWidth: CGFloat = 400
protocol ProgressAnimationDelegate{
    func progressCompleted()

}

class DownloadButtonView: UIView {
    var orignalRect:CGRect
    var shapeLayer:CAShapeLayer?
    var progressDelegate: ProgressAnimationDelegate!
    var downloadLable: UILabel!
    override init(frame: CGRect) {
        self.orignalRect = frame
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(colorLiteralRed: 0.169, green: 0.176, blue: 0.224, alpha: 1)
        self.layer.cornerRadius = self.height / 2;
        self.layer.masksToBounds = true
        self.addDownloadLabel()

    }
    func addDownloadLabel(){
        downloadLable = UILabel.init(frame: CGRectMake(0, 0, self.width, self.height))
        self.addSubview(downloadLable)
        downloadLable.text = "Download"
        downloadLable.textColor = UIColor.whiteColor()
        downloadLable.textAlignment = NSTextAlignment.Center
        downloadLable.font = UIFont.boldSystemFontOfSize(28)
    }
    func startDownload(){
        self.layer.cornerRadius = kProgressBarHeight / 2
        self.bounds = CGRectMake(0, 0, kProgressBarWidth, kProgressBarHeight)

        if shapeLayer != nil{
            return
        }
        
        shapeLayer = CAShapeLayer.init()
        let progressBeizier = UIBezierPath.init()
        progressBeizier.moveToPoint(CGPointMake(kProgressBarHeight / 2, kProgressBarHeight / 2))
        progressBeizier.addLineToPoint(CGPointMake(self.bounds.size.width - kProgressBarHeight / 2, kProgressBarHeight / 2))
        
        self.shapeLayer!.path = progressBeizier.CGPath
        self.shapeLayer!.lineCap = kCALineCapRound
        self.shapeLayer!.lineWidth = kProgressBarHeight - 6
        self.shapeLayer!.strokeColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(self.shapeLayer!)
        
    }
    func downloadItem(progress: Double){
        CATransaction.begin()
        let progressAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        if self.shapeLayer?.animationKeys()?.count > 0{
            progressAnimation.fromValue = self.shapeLayer?.presentationLayer()?.strokeEnd
            self.shapeLayer?.strokeEnd = (self.shapeLayer?.presentationLayer()?.strokeEnd)!
            
        }else{
            progressAnimation.fromValue = 0

        }
        progressAnimation.toValue = progress
        progressAnimation.removedOnCompletion = false
        progressAnimation.fillMode = kCAFillModeBoth
        self.shapeLayer?.addAnimation(progressAnimation, forKey: "strokeEnd")
        CATransaction.commit()
        if progress == 1.0{
            progressDelegate.progressCompleted()
            self.downloadCompleted()
            self.downloadLable.hidden = true
        }
    }
    func downloadCompleted(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.shapeLayer?.opacity = 0
            }, completion: { (Bool) -> Void in
                self.layer.removeAllAnimations()

                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.bounds = CGRectMake(0, 0, kDownloadButtonWidth, kDownloadButtonWidth)
                        self.layer.cornerRadius = kDownloadButtonWidth / 2

                    }, completion: { (Bool) -> Void in
                        
                        self.layer .removeAllAnimations()
                        self .checkAnimation()
                })
                
        })

    }
    func checkAnimation(){
        let checkShapeLayer = CAShapeLayer.init()
        let checkBezier = UIBezierPath.init()
        let rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2)
        checkBezier.moveToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3))
        checkBezier.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3,rectInCircle.origin.y + rectInCircle.size.height*9/10))
        checkBezier.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10, rectInCircle.origin.y + rectInCircle.size.height*2/10))
        
        checkShapeLayer.path = checkBezier.CGPath
        
        checkShapeLayer.lineCap = kCALineCapRound
        
        checkShapeLayer.lineJoin = kCALineJoinRound
        checkShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        checkShapeLayer.fillColor = UIColor.clearColor().CGColor
        checkShapeLayer.lineWidth = 20
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
