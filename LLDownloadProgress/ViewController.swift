//
//  ViewController.swift
//  LLDownloadProgress
//
//  Created by liuk on 15/12/30.
//  Copyright © 2015年 Kai Liu. All rights reserved.
//
import UIKit
let kDownloadButtonWidth: CGFloat = 160

class ViewController: UIViewController, ProgressAnimationDelegate {

    var downloadButtonView:DownloadButtonView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.addDownloadButtonView()
    }
    
    //MARK: - Add SubViews
    func addDownloadButtonView(){
        self.downloadButtonView = DownloadButtonView.init(frame: CGRectMake(0, 0, kDownloadButtonWidth, kDownloadButtonWidth))
        self.downloadButtonView?.progressDelegate = self
        self.downloadButtonView?.backgroundColor = UIColor.init(colorLiteralRed: 0.169, green: 0.176, blue: 0.224, alpha: 1)
        self.downloadButtonView?.center = self.view.center
        self.downloadButtonView?.layer.cornerRadius = kDownloadButtonWidth / 2;
        self.downloadButtonView?.layer.masksToBounds = true
        self.view.addSubview(self.downloadButtonView!)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: "downloadtapGesture")
        self.downloadButtonView?.addGestureRecognizer(tapGesture)
    }

    func downloadtapGesture(){
        self.downloadButtonView?.startDownload()
        self.downloadFile()
    }
    func downloadFile(){
    self.progressItem(0.3)
    self.performSelector("progress", withObject: nil, afterDelay: 0.4)
    self.performSelector("progress1", withObject: nil, afterDelay: 1)
    self.performSelector("progress2", withObject: nil, afterDelay: 2)


    }
    func progress(){
        self.progressItem(0.5)

    }
    func progress1(){
        self.progressItem(0.8)
    }
    func progress2(){
        self.progressItem(1)

    }
    func progressItem(progress: Double){
        self.downloadButtonView?.startDownload()
        self.downloadButtonView?.downloadItem(progress)
        
    }
    // MARK: - ProgressAnimationDelegate
    func progressCompleted(){
        print("Download Finished")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
