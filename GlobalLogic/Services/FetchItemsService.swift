//
//  FetchItemsService.swift
//  GlobalLogic
//
//  Created by Arnaldo Gnesutta on 21/02/2018.
//  Copyright © 2018 Arnaldo Gnesutta. All rights reserved.
//

import AlamofireObjectMapper
import Alamofire

protocol FetchItemsServiceProtocol {
    func fetchItems(onCompletion: @escaping ([Item]?, Error?) -> Void)
}

struct FetchItemsService: FetchItemsServiceProtocol {

    func fetchItems(onCompletion: @escaping ([Item]?, Error?) -> Void) {
        Alamofire.request(API.BaseURL).responseArray() { (response: DataResponse<[Item]>) in
            if let itemList = response.result.value {
                return onCompletion(itemList, nil)
            }
            return onCompletion(nil, response.error)
        }
    }
}
