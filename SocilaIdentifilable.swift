//
//  FacebookIdentifilable.swift
//  InternationalWorld
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import FacebookCore
import GoogleSignIn

protocol SocilaIdentifilable: class {
    func configure(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func configure(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool
}

extension SocilaIdentifilable {
    @discardableResult
    func configure(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "your cliend Id"
        return true
    }

    func configure(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {

        let canHandleFacebookURL = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        let canHandleGoogleUrl = GIDSignIn.sharedInstance().handle(url,
                                                                   sourceApplication: options[.sourceApplication]
                                                                    as? String,
                                                                   annotation: options[.annotation])

        return canHandleFacebookURL || canHandleGoogleUrl
    }
}
