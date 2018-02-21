//
//  ViewController.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {
    var itemList = [Item]()
    let fetchService: FetchItemsServiceProtocol
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    init(fetchService: FetchItemsServiceProtocol) {
        self.fetchService = fetchService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item List"
        view.addSubviewsForAutolayout(tableView)
        fetchItems()
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
        let views = ["tableView": tableView]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[tableView]|", views: views),
            NSLayoutConstraint.constraints("V:|[tableView]|", views: views))
    }

    func fetchItems() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchService.fetchItems { (items, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            guard error == nil, let items = items else { return }
            self.itemList = items
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as? ItemCell
        if cell == nil {
            cell = ItemCell(style: .default, reuseIdentifier: "ItemCell")
        }
        cell?.configure(with: ItemDataModel(itemList[indexPath.row]))

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailsVC = ItemDetailsViewController(ItemDataModel(itemList[indexPath.row]))
        navigationController?.pushViewController(itemDetailsVC, animated: true)
    }
}
