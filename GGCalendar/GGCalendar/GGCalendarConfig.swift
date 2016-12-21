//
//  GGCalendarConfig.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/20.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

public func GGLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

let kCalendarUnitYMD = Set(arrayLiteral: Calendar.Component.year, Calendar.Component.month, Calendar.Component.day)

var SCREEN_WIDTH: CGFloat = 0.0
var SCREEN_HEIGHT: CGFloat = 0.0
