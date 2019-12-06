//
//  TitleAndTextCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit
import Kingfisher

public class TitleAndTextCell: UITableViewCell {
    let stackView = UIStackView()
    let labelsStackView = UIStackView()

    let imgView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

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
        stackView.alignment = .top
        stackView.spacing = 10.0
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }

        imgView.contentMode = .scaleAspectFill

        stackView.addArrangedSubview(imgView)

        imgView.snp.makeConstraints { make in
            make.height.width.equalTo(imgViewSize)
        }

        labelsStackView.axis = .vertical
        labelsStackView.spacing = 0.0
        labelsStackView.alignment = .leading

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        labelsStackView.addArrangedSubview(titleLabel)

        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = UIColor.systemGray
        descriptionLabel.numberOfLines = 0
        labelsStackView.addArrangedSubview(descriptionLabel)

        stackView.addArrangedSubview(labelsStackView)
    }

    public func configure(with model: TitleAndTextCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description

        if let imgUrl = model.imgUrl {
            let cornerRadius: CGFloat = 5.0
            let processor = RoundCornerImageProcessor(cornerRadius: cornerRadius, backgroundColor: UIColor.clear)
            imgView.kf.setImage(with: URL(string: imgUrl), options: [.processor(processor)])

            imgView.isHidden = false
        } else {
            imgView.isHidden = true
        }

    }}
