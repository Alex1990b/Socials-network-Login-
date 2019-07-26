//
//  FacebookAuthenticatableService.swift
//
//  Created by Alex on 5/7/19.
//  Copyright © alex alex. All rights reserved.
//

import FacebookLogin
import FacebookCore
import FacebookShare

final class FacebookAuthenticationService: Authenticatable {

   private let loginManager = LoginManager()
   private let grashRequestParameters = ["fields": "id, email, name, picture.width(480).height(480)"]

   func login(in responder: Routable, completion: @escaping (LoginCompletion) -> Void) {
       loginManager.logIn(readPermissions: [.publicProfile], viewController: responder) { [weak self] loginResult in
           switch loginResult {
           case .failed(let error): completion((error, nil))
           case .cancelled:  completion((nil, nil))
           case .success: self?.fetchUserData(completion: completion)
           }
       }
   }
}

extension FacebookAuthenticationService {
   private func fetchUserData(completion: @escaping (LoginCompletion) -> Void) {

       let connection = GraphRequestConnection()
       connection.add(GraphRequest(graphPath: "/me", parameters: grashRequestParameters)) { _, result in
           switch result {
           case .success(let response):

               completion((nil, FacebookLoginResponse(dictionary: response.dictionaryValue)))
           case .failed(let error): completion((error, nil))
           }
       }
       connection.start()
   }
}
