# LLDownloadProgress
## Usage
1. 初始化一个按钮  <br/>
```
  let downloadButtonView = DownloadButtonView.init(frame: CGRectMake(0, 0, kDownloadButtonWidth, kDownloadButtonWidth))<br/>
  downloadButtonView?.progressDelegate = self  
  downloadButtonView?.center = self.view.center
  self.view.addSubview(downloadButtonView!)
```
        
2. 使用startDownload()来开启progress动画  <br/>
```
   self.downloadButtonView?.startDownload() 
```
3. 下载文件过程中传入progress值给downloadItem()方法  <br/>
```
  self.downloadButtonView?.downloadItem(progress)
```
4. 当你下载完成使用协议方法progressCompleted()进行回调  <br/>
```
   func progressCompleted(){
      print("Download Finished")
   }
```
