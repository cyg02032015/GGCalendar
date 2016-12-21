//
//  GGCalendarViewController.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/20.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit


class GGCalendarViewController: UIViewController {
    
    var v: GGCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewInit()
    }
    
    func configViewInit() {
        let v = GGCalendarView(frame: .zero)
        self.view.addSubview(v)
        self.v = v
        v.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 100))
        self.view.addConstraint(NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: v, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


