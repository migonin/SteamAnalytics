//
//  NewsEntryCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import Kingfisher

public class NewsEntryCell: UITableViewCell {
    let stackView = UIStackView()

    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let separatorView = UIView()
    let newsTextLabel = UILabel()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
//        backgroundColor = .systemGray
        selectionStyle = .none

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2.0
        stackView.isUserInteractionEnabled = false

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0

        stackView.addArrangedSubview(titleLabel)

        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.textColor = UIColor.systemGray
        dateLabel.textAlignment = .right

        stackView.addArrangedSubview(dateLabel)

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }

        stackView.addArrangedSubview(separatorView)

        newsTextLabel.font = UIFont.preferredFont(forTextStyle: .body)
        newsTextLabel.numberOfLines = 0
        stackView.addArrangedSubview(newsTextLabel)
    }

    public func configure(with model: NewsEntryCellModel) {
        titleLabel.text = model.title
        dateLabel.text = model.date
        newsTextLabel.attributedText = model.text
    }}
