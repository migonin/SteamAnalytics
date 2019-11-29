//
//  HeaderCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 YouDo. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

public class HeaderCell: UITableViewCell {
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imgView = UIImageView()

    let imgViewSize: CGFloat = 200.0

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

        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5.0

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
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

        stackView.addArrangedSubview(imgView)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.textColor = UIColor.systemGray
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        subtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(subtitleLabel)
    }

    public func configure(with model: HeaderCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle

        imgView.kf.setImage(with: URL(string: model.imgUrl))

        if model.roundedImg {
            imgView.layer.cornerRadius = imgViewSize / 2.0
        } else {
            imgView.layer.cornerRadius = 16.0
        }
    }
}
