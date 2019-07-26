//
//  LoginResponse.swift
//  InternationalWorld
//
//  Created by SSD on 5/7/19.
//  Copyright © 2019 beard. All rights reserved.
//

import Foundation

struct FacebookLoginResponse: LoginResponse {
    var userName: String?
    var imageUrl: String?

    init?(dictionary: [String: Any]?) {

        if let dictionary = dictionary {
            userName = dictionary["name"] as? String
            let picture = dictionary["picture"] as? [String: Any]
            let data = picture?["data"] as? [String: Any]
            imageUrl = data?["url"] as? String
        } else {
            return nil
        }
    }
}
