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
        
        //因为要使用shrokeEnd属性，所以需要使用shapeLayer
        shapeLayer = CAShapeLayer.init()
        let progressBeizier = UIBezierPath.init()
        progressBeizier.moveToPoint(CGPointMake(kProgressBarHeight / 2, kProgressBarHeight / 2))
        progressBeizier.addLineToPoint(CGPointMake(self.bounds.size.width - kProgressBarHeight / 2, kProgressBarHeight / 2))
        
        //通过贝塞尔曲线绘制shapelayer的路径
        self.shapeLayer!.path = progressBeizier.CGPath
        
        //设置圆角
        self.shapeLayer!.lineCap = kCALineCapRound
        self.shapeLayer!.lineWidth = kProgressBarHeight - 6
        self.shapeLayer!.strokeColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(self.shapeLayer!)
        
    }
    func downloadItem(progress: Double){
        //添加动画
        //strokeEnd（多用于进度条动画）
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
    //修改按钮的bounds（形状）
//    override func animationDidStart(anim: CAAnimation) {
//
//    }
//    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        let animationName = anim.valueForKey("animationName")
//        if (animationName?.isEqualToString("progressAnimation") != nil){
//            UIView.animateWithDuration(0.3, animations: { () -> Void in
//                self.shapeLayer?.opacity = 0
//                }, completion: { (Bool) -> Void in
//
//                    self.layer.removeAllAnimations()
//                    let cornerAnimation = CABasicAnimation.init(keyPath: "cornerRadius")
//                    self.layer.cornerRadius = 80
//                    cornerAnimation.fromValue = 25
//                    cornerAnimation.duration = 0.1
//                    cornerAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
//                    self.layer.addAnimation(cornerAnimation, forKey: nil)
//                    
//                    UIView.animateWithDuration(0.2, animations: { () -> Void in
//                        self.bounds = CGRectMake(0, 0, 160, 160)
//                        }, completion: { (Bool) -> Void in
//                            self.layer .removeAllAnimations()
//                            self .checkAnimation()
//                    })
//                    
//            })
//        }
//
//    }
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
        
        //两端起始点样式
        checkShapeLayer.lineCap = kCALineCapRound
        
        //折角样式
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
