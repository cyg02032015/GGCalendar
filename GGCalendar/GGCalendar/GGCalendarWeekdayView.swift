//
//  GGCalendarWeekdayView.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/21.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class GGCalendarWeekdayView: UICollectionReusableView {
    
    var lastBtn: UIButton?
    func configViews() {
        for _ in 0...6 {
            let btn = UIButton(type: .custom)
            btn.backgroundColor = UIColor.red
            self.addSubview(btn)
            btn.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: btn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: btn, attribute: .left, relatedBy: .equal, toItem: self.lastBtn == nil ? self : self.lastBtn!, attribute: self.lastBtn == nil ? .left : .right, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0/7.0, constant: 0))
            self.lastBtn = btn
        }
    }
    
    func bindData(weekdays: [String]) {
        var i = 0
        for view in self.subviews {
            let btn = view as! UIButton
            btn.setTitle(weekdays[i], for: .normal)
            i = i + 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }
}
