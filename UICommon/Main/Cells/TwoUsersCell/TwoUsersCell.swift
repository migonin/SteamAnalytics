//
//  TwoUsersCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

public class TwoUsersCell: UITableViewCell {
    let leftStackView = UIStackView()
    let rightStackView = UIStackView()

    let leftTitleLabel = UILabel()
    let rightTitleLabel = UILabel()

    let leftImgView = UIImageView()
    let rightImgView = UIImageView()

    let imgViewSize: CGFloat = 100.0

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func setupStackView(_ stackView: UIStackView, titleLabel: UILabel, imageView: UIImageView) {
        addSubview(stackView)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5.0

        imageView.contentMode = .scaleAspectFill

        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(imgViewSize)
        }

        imageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imgViewSize / 2.0

        stackView.addArrangedSubview(imageView)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
    }

    func commonInit() {
        backgroundColor = nil
        selectionStyle = .none

        setupStackView(leftStackView, titleLabel: leftTitleLabel, imageView: leftImgView)
        setupStackView(rightStackView, titleLabel: rightTitleLabel, imageView: rightImgView)

        leftStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(rightStackView.snp.leading)
            make.width.equalTo(rightStackView)
        }

        rightStackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5.0)
            make.trailing.equalTo(snp.trailingMargin)
        }

    }

    public func configure(with model: TwoUsersCellModel) {
        leftTitleLabel.text = model.leftTitle
        rightTitleLabel.text = model.rightTitle

        leftImgView.kf.setImage(with: URL(string: model.leftImgUrl))
        rightImgView.kf.setImage(with: URL(string: model.rightImgUrl))
    }
}
