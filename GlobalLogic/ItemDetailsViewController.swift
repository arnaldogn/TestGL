//
//  ItemDetailViewController.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    var item: ItemDataModel
    let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        title.textAlignment = .center
        return title
    }()
    let details: UILabel = {
        let details = UILabel()
        details.textColor = .gray
        details.numberOfLines = 0
        details.font = UIFont.systemFont(ofSize: 13)
        return details
    }()

    init(_ item: ItemDataModel) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item Detail"
        view.addSubviewsForAutolayout(itemImage, titleLabel, details)
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white

        titleLabel.text = item.title
        details.text = item.details
        itemImage.sd_addActivityIndicator()
        itemImage.sd_setImage(with: item.thumbnail, placeholderImage: UIImage(named: "UserPlaceholder"), completed: nil)
    }

    func setupConstraints() {
        let views: [String : Any] = ["itemImage": itemImage,
                                     "titleLabel": titleLabel,
                                     "details": details]

        view.addConstraints(NSLayoutConstraint.constraints("H:[itemImage(150)]", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[titleLabel]-30-|", views: views),
                            NSLayoutConstraint.constraints("H:|-30-[details]-30-|", views: views),
                            NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[itemImage(150)]-20-[titleLabel]-10-[details]", options: .alignAllCenterX, metrics: nil, views: views))
        view.addConstraint(NSLayoutConstraint(item: itemImage,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0))
    }
}
