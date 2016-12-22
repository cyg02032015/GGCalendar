//
//  GGCalendarCollectionCell.swift
//  GGCalendar
//
//  Created by Youngkook on 2016/12/21.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class GGCalendarCollectionCell: UICollectionViewCell {

    lazy var dayLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .green
        return label
    }()
    
    func configViews() {
        self.contentView.addSubview(self.dayLabel)
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dayLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dayLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dayLabel, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dayLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func bindData(item: DaysModel) {
        dayLabel.text = item.day
        switch item.monthType {
        case .LastMonth: self.dayLabel.textColor = .gray
        case .ThisMonth: self.dayLabel.textColor = .black
        case .NextMonth: self.dayLabel.textColor = .gray
        }
        var componens = DateComponents()
        componens.day = Int(item.day)
        componens.month = Int(item.month)
        componens.year = Int(item.year)
        if GGCalendarTool.isToday(components: componens) {
            dayLabel.backgroundColor = .gray
        } else {
            dayLabel.backgroundColor = .white
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
