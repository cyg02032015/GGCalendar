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
    
    var showPaddingDays: Bool = true
    lazy var visibleYear: Int = {
        let date = Date()
        let components = GGCalendarTool.dateComponentsFromDate(date: date)
        return components.year ?? 1
    }()
    lazy var visibleMonth: Int = {
        let date = Date()
        let components = GGCalendarTool.dateComponentsFromDate(date: date)
        return components.month ?? 1
    }()
    
    lazy var titleText: String = {
        let date = Date()
        let components = GGCalendarTool.dateComponentsFromDate(date: date)
        return "\(components.year!)年\(components.month!)月"
    }()
    
    lazy var daysArr = [DaysModel]()
    lazy var collectionView: UICollectionView = {
        let layout = GGCollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 40)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(GGCalendarCollectionCell.self, forCellWithReuseIdentifier: CalendarCollectionCellId)
        cv.register(GGCalendarWeekdayView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GGCalendarWeekdayViewId)
        return cv
    }()
    
    lazy var calendarBar: GGTopCalendarBar = {
       let bar = GGTopCalendarBar(frame: .zero)
        bar.delegate = self
        bar.title.text = self.titleText
        return bar
    }()
    
    func configViews() {
        addSubview(self.calendarBar)
        self.calendarBar.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.calendarBar, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.calendarBar, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.calendarBar, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.calendarBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        
        addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: self.calendarBar, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        daysArr = GGCalendarTool.calculateDays(month: self.visibleMonth, year: self.visibleYear, showPaddingDays: showPaddingDays)
        configViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        daysArr = GGCalendarTool.calculateDays(month: self.visibleMonth, year: self.visibleYear, showPaddingDays: showPaddingDays)
        configViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        daysArr = GGCalendarTool.calculateDays(month: self.visibleMonth, year: self.visibleYear, showPaddingDays: showPaddingDays)
        configViews()
        
    }
}

extension GGCalendarView: GGTopCalendarProtocol {
    func topbarItemClick(btn: UIButton) {
        daysArr.removeAll()
        if btn.tag == preTag {
            self.visibleYear = self.visibleMonth - 1 == 0 ? self.visibleYear - 1 : self.visibleYear
            self.visibleMonth = self.visibleMonth - 1 == 0 ? 12 : self.visibleMonth - 1
            daysArr.append(contentsOf: GGCalendarTool.calculateDays(month: self.visibleMonth, year: self.visibleYear, showPaddingDays: showPaddingDays))
            collectionView.reloadData()
        } else if btn.tag == nextTag {
            self.visibleYear = self.visibleMonth + 1 == 13 ? self.visibleYear + 1 : self.visibleYear
            self.visibleMonth = self.visibleMonth + 1 == 13 ? 1 : self.visibleMonth + 1
            daysArr.append(contentsOf: GGCalendarTool.calculateDays(month: self.visibleMonth, year: self.visibleYear, showPaddingDays: showPaddingDays))
            collectionView.reloadData()
        } else {
            GGLog(message: "未知")
        }
        calendarBar.title.text = "\(self.visibleYear)年\(self.visibleMonth)月"
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
        let item = daysArr[indexPath.item]
        cell.bindData(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = daysArr[indexPath.item]
        GGLog(message: "\(item.year!)年\(item.month!)月\(item.day!)日")
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
