//
//  Loginable.swift
//  InternationalWorld
//
//  Created by SSD on 5/7/19.
//  Copyright © 2019 beard. All rights reserved.
//

import UIKit

typealias LoginCompletion = (Error?, LoginResponse?)

protocol Authenticatable {
     func login(in responder: Routable,
                completion: @escaping (LoginCompletion) -> Void)
}

protocol AuthenticatableResponder {
    func login(with responder: Routable,
               with service: Authenticatable,
               completion: @escaping (LoginCompletion) -> Void)
}

extension AuthenticatableResponder {

    func login(with responder: Routable,
               with service: Authenticatable,
               completion: @escaping  (LoginCompletion) -> Void) {
        service.login(in: responder, completion: completion)
    }
}
