//
//  GGIndicatorView.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/26.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit
import CoreGraphics

class GGIndicatorView: UIView {

    var ellipseLayer: CAShapeLayer = CAShapeLayer()
    var _color: UIColor!
    var color: UIColor! {
        get {
            if _color == nil {
                self.color = .red
            }
            return _color
        }
        set {
            _color = newValue
            self.ellipseLayer.fillColor = _color.cgColor
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
//        self.ellipseLayer.fillColor = UIColor.red.cgColor
        self.layer.addSublayer(self.ellipseLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ellipseLayer.path = CGPath(ellipseIn: self.bounds, transform: nil)
        self.ellipseLayer.frame = self.frame
        GGLog(message: "self.bounds = \(self.frame)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
