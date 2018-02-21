//
//  ItemCell.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell: UITableViewCell {
    let thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        return title
    }()
    let details: UILabel = {
        let details = UILabel()
        details.textColor = .gray
        details.font = UIFont.systemFont(ofSize: 13)
        return details
    }()
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        selectionStyle = .none
        contentView.addSubviewsForAutolayout(thumbnail, title, details, separator)
        setupConstraints()
    }

    func setupConstraints() {
        let views: [String: Any] = ["thumbnail": thumbnail,
                                    "title": title,
                                    "details": details,
                                    "separator": separator]
        contentView.addConstraints(
            NSLayoutConstraint.constraints("H:|-20-[thumbnail(60)]-15-[title]-10-|", views: views),
            NSLayoutConstraint.constraints("H:[details]-10-|", views: views),
            NSLayoutConstraint.constraints("H:|-20-[separator]-20-|", views: views),
            NSLayoutConstraint.constraints("V:[thumbnail(60)]", views: views),
            NSLayoutConstraint.constraints("V:[separator(1)]", views: views),
            NSLayoutConstraint.constraints("V:[title]-5-[separator]-5-[details]", views: views))

        contentView.addConstraint(NSLayoutConstraint(item: thumbnail,
                                                     attribute: .centerY,
                                                     relatedBy: .equal,
                                                     toItem: contentView,
                                                     attribute: .centerY,
                                                     multiplier: 1,
                                                     constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: separator,
                                                     attribute: .centerY,
                                                     relatedBy: .equal,
                                                     toItem: contentView,
                                                     attribute: .centerY,
                                                     multiplier: 1,
                                                     constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: details,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: title,
                                                     attribute: .leading,
                                                     multiplier: 1,
                                                     constant: 0))

        contentView.addConstraints(constraints)
    }

    func configure(with item: ItemDataModel) {
        title.text = item.title
        details.text = item.details
        thumbnail.sd_addActivityIndicator()
        thumbnail.sd_setImage(with: item.thumbnail, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
}

