//
//  GGTopCalendarBar.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/22.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

let preTag = 1000000
let nextTag = 2000000

protocol GGTopCalendarProtocol: NSObjectProtocol {
    
    func topbarItemClick(btn: UIButton)
}

class GGTopCalendarBar: UIView {

    weak var delegate: GGTopCalendarProtocol?
    var title: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    func configViews() {
        let pre = UIButton(type: .custom)
        pre.setTitle("Pre", for: .normal)
        pre.tag = preTag
        pre.setTitleColor(.black, for: .normal)
        pre.addTarget(self, action: #selector(GGTopCalendarBar.btnClick(btn:)), for: .touchUpInside)
        self.addSubview(pre)
        pre.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: pre, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint(item: pre, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pre, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pre, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        
        let next = UIButton(type: .custom)
        next.tag = nextTag
        next.addTarget(self, action: #selector(GGTopCalendarBar.btnClick(btn:)), for: .touchUpInside)
        next.setTitle("next", for: .normal)
        next.setTitleColor(.black, for: .normal)
        self.addSubview(next)
        next.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: next, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
        self.addConstraint(NSLayoutConstraint(item: next, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: next, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: next, attribute: .width, relatedBy: .equal, toItem: pre, attribute: .width, multiplier: 1, constant: 0))
        
        addSubview(self.title)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.title, attribute: .left, relatedBy: .equal, toItem: pre, attribute: .right, multiplier: 1, constant: 10))
        self.addConstraint(NSLayoutConstraint(item: self.title, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.title, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.title, attribute: .right, relatedBy: .equal, toItem: next, attribute: .left, multiplier: 1, constant: -10))
    }
    
    func btnClick(btn: UIButton) {
        if delegate != nil {
            self.delegate?.topbarItemClick(btn: btn)
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

}
