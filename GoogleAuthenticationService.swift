//
//  GoogleAuthenticationService.swift
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 alex. All rights reserved.
//

import GoogleSignIn

final class GoogleAuthenticationService: NSObject, Authenticatable, GIDSignInDelegate, GIDSignInUIDelegate {

    private var didLogin: ((LoginCompletion) -> Void)?

    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    func login(in responder: Routable, completion: @escaping (LoginCompletion) -> Void) {
          didLogin = completion
          GIDSignIn.sharedInstance()?.signOut()
          GIDSignIn.sharedInstance().signIn()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            didLogin?((error, nil))
            return
        }

        if let user = user {
            let googleLoginResponse = GoogleLoginResponse(userName: user.profile.name,
                                        imageUrl: user.profile.imageURL(withDimension: 0)?.absoluteString)
            didLogin?((nil, googleLoginResponse))
        }
    }

    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) { }
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) { }
}
