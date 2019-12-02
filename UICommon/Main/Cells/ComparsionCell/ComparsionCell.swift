//
//  ComparsionCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

public class ComparsionCell: UITableViewCell {
    let titleLabel = UILabel()

    let leftCountLabel = UILabel()
    let rightCountLabel = UILabel()

    let progressView = UIProgressView()

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

        addSubview(progressView)

        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(snp.leadingMargin)
            make.trailingMargin.equalTo(snp.trailingMargin)
        }

        leftCountLabel.textColor = UIColor.systemGray
        leftCountLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

        addSubview(leftCountLabel)
        addSubview(rightCountLabel)

        leftCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.leading.equalTo(snp.leadingMargin)
            make.trailingMargin.equalTo(rightCountLabel.snp.leading)
            make.bottom.equalToSuperview().inset(10)
        }

        rightCountLabel.textColor = UIColor.systemGray
        rightCountLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        rightCountLabel.textAlignment = .right

        rightCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.trailingMargin.equalTo(snp.trailingMargin)
            make.width.equalTo(leftCountLabel)
        }
    }

    public func configure(with model: ComparsionCellModel) {
        titleLabel.text = model.title
        leftCountLabel.text = "\(Int(model.leftValue))"
        rightCountLabel.text = "\(Int(model.rightValue))"

        progressView.progressTintColor = model.leftColor
        progressView.trackTintColor = model.rightColor

        if model.leftValue == model.rightValue {
            progressView.progress = 0.5
        } else {
            progressView.progress = Float(model.leftValue / (model.leftValue + model.rightValue))
        }
    }
}
