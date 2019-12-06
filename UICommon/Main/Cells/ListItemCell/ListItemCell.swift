//
//  ListItemCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import UIKit
import Kingfisher

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
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.height.equalTo(imgViewSize).priority(999)
            make.top.bottom.equalToSuperview().inset(5.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }

        imgView.contentMode = .scaleAspectFill

        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(imgViewSize)
        }

        stackView.addArrangedSubview(imgView)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
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
            let cornerRadius = model.roundedImg ? imgViewSize : 5.0
            let processor = RoundCornerImageProcessor(cornerRadius: cornerRadius, backgroundColor: UIColor.clear)
            imgView.kf.setImage(with: URL(string: imgUrl), options: [.processor(processor)])

            imgView.isHidden = false
        } else {
            imgView.image = nil
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
