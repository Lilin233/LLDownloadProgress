//
//  UIViewEx.swift
//  BestCamera
//
//  Created by liuk on 11/22/15.
//  Copyright © 2015 Kai Liu. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    var width : CGFloat{
        return self.frame.size.width
    }
    var height : CGFloat{
        return self.frame.size.height
    }
    var top : CGFloat{
        return self.frame.origin.y
    }
    var right : CGFloat{
        return self.frame.origin.x + self.frame.size.width
    }
    var bottom : CGFloat{
        return self.frame.origin.y + self.frame.size.height
    }
    var left : CGFloat{
        return self.frame.origin.x
    }
    
    func setWidth(width: CGFloat) ->CGRect{
        var frame = self.frame
        frame.size.width = width
        return frame
    }
    func setHeight(height: CGFloat) ->CGRect{
        var frame = self.frame
        frame.size.height = height
        return frame
    }
    func setOrigin(origin: CGPoint) -> CGRect{
        var frame = self.frame
        frame.origin = origin
        return frame
    }
    func setSize(size: CGSize) -> CGRect{
        var frame = self.frame
        frame.size = size
        return frame
    }
}