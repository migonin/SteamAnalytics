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
    let separatorView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let subsubtitleLabel = UILabel()
    let imgView = UIImageView()

    let imgViewHeight: CGFloat = 120.0

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
        separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2.0

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5.0)
            make.bottom.equalToSuperview().inset(15.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }

        imgView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imgView)

        imgView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(imgViewHeight)
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }

        stackView.addArrangedSubview(separatorView)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        subtitleLabel.textColor = UIColor.systemGray
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        subtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(subtitleLabel)

        subsubtitleLabel.textColor = UIColor.systemGray
        subsubtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        subsubtitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(subsubtitleLabel)
    }

    public func configure(with model: HeaderCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        subsubtitleLabel.text = model.subsubtitle

        if model.roundedImg {
            let processor = RoundCornerImageProcessor(cornerRadius: imgViewHeight, backgroundColor: nil)
            imgView.kf.setImage(with: URL(string: model.imgUrl), options: [.processor(processor)])
        } else {
            imgView.kf.setImage(with: URL(string: model.imgUrl))
        }

        imgView.contentMode = model.fillImage ? .scaleAspectFill : .scaleAspectFit

        if model.alignment != .center {
            stackView.alignment = model.alignment
        }
    }
}
