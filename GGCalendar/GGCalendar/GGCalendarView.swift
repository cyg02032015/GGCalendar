//
//  GGCalendarView.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/21.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

let CalendarCollectionCellId = "calendarCollectionCellId"
let GGCalendarWeekdayViewId = "GGCalendarWeekdayViewId"
class GGCalendarView: UIView {
    
    var visibleYear: Int = 2016
    var visibleMonth: Int = 12
    lazy var daysArr = [DaysModel]()
    lazy var collectionView: UICollectionView = {
        let layout = GGCollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.yellow
        cv.register(GGCalendarCollectionCell.self, forCellWithReuseIdentifier: CalendarCollectionCellId)
        cv.register(GGCalendarWeekdayView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GGCalendarWeekdayViewId)
        return cv
    }()
    
    func configViews() {
        addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        calculateDays()
        configViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        calculateDays()
        configViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        calculateDays()
        configViews()
        
    }

}

extension GGCalendarView {
    
    func calculateDays() -> Void {
        let totalDays = GGCalendarTool.daysIn(month: self.visibleMonth, ofYear: self.visibleYear)
        let paddingDays = GGCalendarTool.weekInFirstDay(month: self.visibleMonth, ofYear: self.visibleYear) - 1
        let paddingYear = self.visibleMonth == 1 ? self.visibleYear - 1 : self.visibleYear
        let paddingMonth = self.visibleMonth == 1 ? 12 : self.visibleMonth - 1
        let totalDaysInLastMonth = GGCalendarTool.daysIn(month: paddingMonth, ofYear: paddingYear)
        for i in (0..<paddingDays).reversed() {
            let day = totalDaysInLastMonth - i
            var days = DaysModel()
            days.day = "\(day)"
            days.monthType = .LastMonth
            daysArr.append(days)
        }
        // 这个月日期
        for day in 1...totalDays {
            var days = DaysModel()
            days.day = "\(day)"
            days.monthType = .ThisMonth
            daysArr.append(days)
        }
//        let fillYear = self.visibleMonth == 12 ? self.visibleYear + 1 : self.visibleYear
//        let fillMonth = self.visibleMonth == 12 ? 1 : self.visibleMonth + 1
        for day in 1...(42-daysArr.count) {
            var days = DaysModel()
            days.day = "\(day)"
            days.monthType = .NextMonth
            daysArr.append(days)
        }
    }
}

// MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension GGCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionCellId, for: indexPath) as! GGCalendarCollectionCell
        cell.bindData(item: daysArr[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GGCalendarWeekdayViewId, for: indexPath) as! GGCalendarWeekdayView
            let weekdays = GGCalendarTool.weekString(type: .ChineseSymbols)
            header.bindData(weekdays: weekdays)
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/7.0, height: 40)
    }
}
