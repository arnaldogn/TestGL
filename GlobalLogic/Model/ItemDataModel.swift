//
//  ItemViewModel.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import Foundation

class ItemDataModel: NSObject {
    let item: Item

    init(_ item: Item) {
        self.item = item
    }
    var title: String {
        return item.title ?? ""
    }
    var details: String {
        return item.details ?? ""
    }
    var thumbnail: URL? {
        return item.thumbnail
    }
}
