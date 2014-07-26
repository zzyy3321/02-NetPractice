//
//  AppDelegate.swift
//  01-WebView
//
//  Created by 刘凡 on 14/7/26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor();
        self.window!.rootViewController = ViewController()
        self.window!.makeKeyAndVisible()
        
        return true
    }

}

