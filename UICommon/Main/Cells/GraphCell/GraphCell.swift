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

public class GraphCell: UITableViewCell, ChartViewDelegate {
    let titleLabel = UILabel()
    let chartView = LineChartView()

    public var id: String!
    var transformHandler: ((String, CGAffineTransform) -> Void)?

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

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)

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
            make.bottom.equalToSuperview().inset(5)
        }

        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
        if let preferredLanguage = Locale.preferredLanguages.first {
            formatter.locale = Locale(identifier: preferredLanguage)
        }

        formatter.dateFormat = "d MMMM HH:mm"

        let xValuesNumberFormatter = ChartXAxisFormatter(dateFormatter: formatter)

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 2
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = xValuesNumberFormatter

        xAxis.gridColor = UIColor.systemGray.withAlphaComponent(0.25)
        xAxis.axisLineColor = UIColor.systemGray
//        xAxis.axisLineWidth = 0
        xAxis.labelTextColor = UIColor.systemGray

        let leftAxis = chartView.leftAxis
        leftAxis.labelTextColor = UIColor.systemGray
        leftAxis.axisLineColor = UIColor.systemGray
        leftAxis.gridColor = UIColor.systemGray.withAlphaComponent(0.25)
        leftAxis.gridLineWidth = 0.5

        let rightAxis = chartView.rightAxis
        rightAxis.labelTextColor = UIColor.systemGray
        rightAxis.axisLineColor = UIColor.systemGray
        rightAxis.gridColor = UIColor.clear

        chartView.pinchZoomEnabled = true
        chartView.scaleYEnabled = false
        chartView.delegate = self
    }

    public func configure(with model: GraphCellModel) {
        titleLabel.text = model.title
        id = model.id

        let dataEntries = model.values.map { (date: Date, value: Int) -> ChartDataEntry in
            return ChartDataEntry(x: date.timeIntervalSinceReferenceDate, y: Double(value))
        }

        let dataSet = LineChartDataSet(entries: dataEntries, label: nil)

        dataSet.colors = [UIColor.systemGray]
        dataSet.mode = .cubicBezier
        dataSet.setCircleColor(UIColor.red)
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = false

        dataSet.valueFont = .systemFont(ofSize: 8)
        dataSet.valueTextColor = UIColor.systemGray

        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false

        chartView.data = LineChartData(dataSet: dataSet)
        chartView.legend.form = .none

        transformHandler = model.transformHandler
        chartView.viewPortHandler.refresh(newMatrix: model.initialTransform, chart: chartView, invalidate: false)
    }

    public func updateTransform(_ transform: CGAffineTransform) {
        chartView.viewPortHandler.refresh(newMatrix: transform, chart: chartView, invalidate: false)
    }

    public func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        transformHandler?(id, chartView.viewPortHandler.touchMatrix)
    }

    public func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        transformHandler?(id, chartView.viewPortHandler.touchMatrix)
    }

}
