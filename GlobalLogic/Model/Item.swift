//
//  Item.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import ObjectMapper

struct Item {
    var title: String?
    var details: String?
    var thumbnail: URL?
}

extension Item: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        title <- map["title"]
        details <- map["description"]
        thumbnail <- (map["image"], URLTransform())
    }
}

