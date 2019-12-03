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

public extension Notification.Name {
    static let didPan = Notification.Name("didPan")
    static let didScale = Notification.Name("didZoom")
}

public class GraphCell: UITableViewCell, ChartViewDelegate {
    let titleLabel = UILabel()
    let chartView = LineChartView()

    let xPanKey = "xPanKey"
    let xScaleKey = "xScaleKey"

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()

        NotificationCenter.default.addObserver(self, selector: #selector(didPan(_:)), name: .didPan, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didScale(_:)), name: .didScale, object: nil)
    }

    @objc func didPan(_ notification: Notification) {
        if let notificationCell = notification.object as? GraphCell,
            notificationCell !== self,
            let dx = notification.userInfo?[xPanKey] as? Double {
            chartView.moveViewToX(dx)
        }
    }

    @objc func didScale(_ notification: Notification) {
        if let notificationCell = notification.object as? GraphCell,
            notificationCell !== self,
            let scale = notification.userInfo?[xScaleKey] as? CGFloat{

        }
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
            make.bottom.equalToSuperview().inset(20)
        }

        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
        formatter.locale = Locale.current
        formatter.dateFormat = "d MMM HH:mm"

        let xValuesNumberFormatter = ChartXAxisFormatter(dateFormatter: formatter)

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 2
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = xValuesNumberFormatter

        chartView.pinchZoomEnabled = true
        chartView.scaleYEnabled = false
        chartView.delegate = self
    }

    public func configure(with model: GraphCellModel) {
        titleLabel.text = model.title

        let dataEntries = model.values.map { (date: Date, value: Int) -> ChartDataEntry in
            return ChartDataEntry(x: date.timeIntervalSinceReferenceDate, y: Double(value))
        }

        let dataSet = LineChartDataSet(entries: dataEntries, label: nil)

        dataSet.colors = [.blue]
        dataSet.mode = .cubicBezier
        dataSet.setCircleColor(.black)
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 8)
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false

        chartView.data = LineChartData(dataSet: dataSet)
    }

    public func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        var notification = Notification(name: .didPan)
        notification.userInfo = [xPanKey: Double(dX)]
        notification.object = self

//        NotificationCenter.default.post(notification)

//        print("Chart translated \(chartView) \(dY)")
    }

    public func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        var notification = Notification(name: .didScale)
        notification.userInfo = [xScaleKey: scaleX]
        notification.object = self

//        NotificationCenter.default.post(notification)
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter!

    convenience init(dateFormatter: DateFormatter) {
        self.init()
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSinceReferenceDate: value)
        return dateFormatter.string(from: date)
    }

}
