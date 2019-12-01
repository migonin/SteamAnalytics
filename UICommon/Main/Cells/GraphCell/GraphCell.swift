//
//  GraphCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Charts

public class GraphCell: UITableViewCell {
    let titleLabel = UILabel()
    let chartView = UIView()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
        backgroundColor = nil
        selectionStyle = .none

        addSubview(titleLabel)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(snp.leadingMargin)
            make.trailingMargin.equalTo(snp.trailingMargin)
        }

        addSubview(chartView)

        chartView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(5)
        }
    }

    public func configure(with model: GraphCellModel) {
        titleLabel.text = model.title

//        let dataEntries = model.values.map { (date: Date, value: Int) -> ChartDataEntry in
//            return ChartDataEntry(x: date.timeIntervalSinceNow, y: Double(value))
//        }
//
//        let dataSet = LineChartDataSet(entries: dataEntries)
//
////        dataSet.lineDashLengths = [5, 2.5]
////        dataSet.highlightLineDashLengths = [5, 2.5]
//        dataSet.colors = [.blue]
//        dataSet.mode = .linear
////        dataSet.setCircleColor(.black)
//        dataSet.lineWidth = 1
////        dataSet.circleRadius = 3
////        dataSet.drawCircleHoleEnabled = false
////[        dataSet.valueFont = .systemFont(ofSize: 9)
////        dataSet.formLineDashLengths = [5, 2.5]
////        dataSet.formLineWidth = 1
////        dataSet.formSize = 15
//
//        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
//                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
//
////        dataSet.fillAlpha = 1
////        dataSet.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
////        dataSet.drawFilledEnabled = true
//        
//        chartView.data = ChartData(dataSet: dataSet)
//        chartView.pinchZoomEnabled = true


    }
}
