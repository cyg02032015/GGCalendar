//
//  GGCalendarTool.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/21.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

enum WeekDaySymbolsType {
    //["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    case WeekdaySymbols
    //["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    case ShortWeekdaySymbols
    //["S", "M", "T", "W", "T", "F", "S"]
    case VeryShortWeekdaySymbols
    //["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    case StandaloneWeekdaySymbols
    //["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    case ShortStandaloneWeekdaySymbols
    //["S", "M", "T", "W", "T", "F", "S"]
    case VeryShortStandaloneWeekdaySymbols
    //[一,二]
    case ChineseSymbols
}

enum MonthSymbolsType {
    //["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    case MonthSymbols
    //["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    case ShortMonthSymbols
    //["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"]
    case VeryShortMonthSymbols
    //["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    case StandaloneMonthSymbols
    //["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    case ShortStandaloneMonthSymbols
    //["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"]
    case VeryShortStandaloneMonthSymbols
    //["1月", "2月"...]
    case ChineseSymbols
}

class GGCalendarTool: NSObject {
    
    static let calendar: Calendar = {
        var c = Calendar(identifier: .gregorian)
        c.locale = Locale.current
        return c
    }()
    
    /// 根据年月日获取Date
    class func dateWith(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return self.dateFromDatecomponents(components: components)
    }
    
    /// 输入年月返回 当月的第一天
    class func dateWith(month: Int, year: Int) -> Date {
        return self.dateWith(day: 1, month: month, year: year)
    }
    
    /// 获取指定月份的天数
    class func daysIn(month: Int, ofYear year: Int) -> Int {
        let date = self.dateWith(month: month, year: year)
        guard let days = self.calendar.range(of: .day, in: .month, for: date) else { fatalError("daysInMonthOfYear returns nil") }
        return days.count
    }
    
    /// 计算某个月第一天是周几 1周日 2 周一 。。。
    class func weekInFirstDay(month: Int, ofYear year: Int) -> Int {
        let date = self.dateWith(month: month, year: year)
        return self.calendar.component(.weekday, from: date)
    }
    
    class func monthString(type: MonthSymbolsType) -> [String] {
        switch type {
        case .MonthSymbols: return self.calendar.monthSymbols
        case .ShortMonthSymbols: return self.calendar.shortMonthSymbols
        case .VeryShortMonthSymbols: return self.calendar.veryShortMonthSymbols
        case .StandaloneMonthSymbols: return self.calendar.standaloneMonthSymbols
        case .ShortStandaloneMonthSymbols: return self.calendar.shortStandaloneMonthSymbols
        case .VeryShortStandaloneMonthSymbols: return self.calendar.veryShortStandaloneMonthSymbols
        case .ChineseSymbols: return ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        }
    }
    
    class func weekString(type: WeekDaySymbolsType) -> [String] {
        switch type {
        case .WeekdaySymbols: return self.calendar.weekdaySymbols
        case .ShortWeekdaySymbols: return self.calendar.shortWeekdaySymbols
        case .VeryShortWeekdaySymbols: return self.calendar.veryShortWeekdaySymbols
        case .StandaloneWeekdaySymbols: return self.calendar.standaloneWeekdaySymbols
        case .ShortStandaloneWeekdaySymbols: return self.calendar.shortStandaloneWeekdaySymbols
        case .VeryShortStandaloneWeekdaySymbols: return self.calendar.veryShortStandaloneWeekdaySymbols
        case .ChineseSymbols: return ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        }
    }
    
    /// 日期转换Components组件
    class func dateComponentsFromDate(date: Date) -> DateComponents {
        return self.calendar.dateComponents(kCalendarUnitYMD, from: date)
    }
    
    class func dateFromDatecomponents(components: DateComponents) -> Date {
        guard let date = self.calendar.date(from: components) else { fatalError("DateFromDatecomponents return nil") }
        return date
    }
}
