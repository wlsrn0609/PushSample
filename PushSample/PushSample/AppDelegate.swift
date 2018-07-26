//
//  AppDelegate.swift
//  PushSample
//
//  Created by m2comm on 2018. 7. 26..
//  Copyright © 2018년 wlsrn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NotiCenter.shared.authorizationCheck()
        
        
        return true
    }



}

