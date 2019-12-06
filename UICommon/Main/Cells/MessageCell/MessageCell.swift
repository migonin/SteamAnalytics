//
//  ListItemCell.swift
//  UICommon
//
//  Created by Михаил Игонин on 29.11.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import UIKit

public class MessageCell: UITableViewCell {
    let titleLabel = UILabel()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor.systemGray
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5.0)
            make.leading.equalTo(snp.leadingMargin)
            make.trailing.equalTo(snp.trailingMargin)
        }
    }

    public func configure(with model: MessageCellModel) {
        titleLabel.text = model.title

    }
}
