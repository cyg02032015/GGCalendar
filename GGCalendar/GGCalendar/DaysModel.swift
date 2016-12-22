//
//  DaysModel.swift
//  GGCalendar
//
//  Created by C on 2016/12/21.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

enum MonthType {
    case ThisMonth
    case LastMonth
    case NextMonth
}

struct DaysModel {
    var year: String!
    var month: String!
    var day: String!
    var monthType: MonthType = MonthType.ThisMonth
}
