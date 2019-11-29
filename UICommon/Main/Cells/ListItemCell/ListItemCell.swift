//
//  ListItemCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import UIKit

public class ListItemCell: UITableViewCell {
    let stackView = UIStackView()
    let imgView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let accessoryPlaceholder = UIView()

    let imgViewSize: CGFloat = 40.0

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10.0

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.height.equalTo(44).priority(999)
            make.top.bottom.equalToSuperview().inset(5.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }

        imgView.contentMode = .scaleAspectFill

        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(imgViewSize)
        }

        imgView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 4.0

        stackView.addArrangedSubview(imgView)

        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.textColor = UIColor.systemGray
        stackView.addArrangedSubview(subtitleLabel)

        accessoryPlaceholder.snp.makeConstraints { make in
            make.width.height.equalTo(10.0)
        }

        stackView.addArrangedSubview(accessoryPlaceholder)
    }

    public func configure(with model: ListItemCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle

        if let imgUrl = model.imgUrl {
            imgView.kf.setImage(with: URL(string: imgUrl))
            imgView.isHidden = false
        } else {
            imgView.isHidden = true
        }

        if model.showDisclosureIndicator {
            selectionStyle = .default

            accessoryType = .disclosureIndicator
            accessoryPlaceholder.isHidden = false
        } else {
            selectionStyle = .none

            accessoryType = .none
            accessoryPlaceholder.isHidden = true
        }
    }}
