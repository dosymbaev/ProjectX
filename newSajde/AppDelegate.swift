//
//  AppDelegate.swift
//  newSajde
//
//  Created by Dias Dosymbaev on 7/6/16.
//  Copyright © 2016 Dias Dosymbaev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let defaults = NSUserDefaults.standardUserDefaults()
    var window: UIWindow?
    var nav: UINavigationController?
    var controller: SLPagingViewSwift!
    let frontColor = UIColorFromHex(0xffffff, alpha: 1.0)
    let backColor = UIColorFromHex(0xffffff, alpha: 0.5)
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        
        if(UIApplication.instancesRespondToSelector(#selector(UIApplication.registerUserNotificationSettings(_:)))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        }
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if defaults.stringForKey("cityNames") != nil {
            loadMainPages()
        } else {
            self.window?.rootViewController = SelectCityViewController()
        }
        self.window?.makeKeyAndVisible()
        return true
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0
    }
    func loadMainPages() {
        let ctr1 = CounterViewController()
        let ctr2 = TimeViewController()
        let ctr3 = OthersViewController()
        
        var img1 = UIImage(named: "plus")
        img1 = img1?.imageWithRenderingMode(.AlwaysTemplate)
        var img2 = UIImage(named: "clock")
        img2 = img2?.imageWithRenderingMode(.AlwaysTemplate)
        var img3 = UIImage(named: "menu")
        img3 = img3?.imageWithRenderingMode(.AlwaysTemplate)
        
        let items = [UIImageView(image: img1), UIImageView(image: img2), UIImageView(image: img3)]
        let controllers = [ctr1, ctr2, ctr3]
        controller = SLPagingViewSwift(items: items, controllers: controllers, showPageControl: false)
        controller.pagingViewMoving = ({ subviews in
            if let imageViews = subviews as? [UIImageView] {
                for imgView in imageViews {
                    var c = self.backColor
                    let originX = Double(imgView.frame.origin.x)
                    
                    if (originX > 45 && originX < 145) {
                        c = self.gradient(originX, topX: 46, bottomX: 144, initC: self.frontColor, goal: self.backColor)
                    }
                    else if (originX > 145 && originX < 245) {
                        c = self.gradient(originX, topX: 146, bottomX: 244, initC: self.backColor, goal: self.frontColor)
                    }
                    else if(originX == 145){
                        c = self.frontColor
                    }
                    imgView.tintColor = c
                }
            }
        })
        
        self.nav = UINavigationController(rootViewController: self.controller)
        self.window?.rootViewController = self.nav
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func viewWithBackground(color: UIColor) -> UIView{
        let v = UIView()
        v.backgroundColor = color
        return v
    }
    func gradient(percent: Double, topX: Double, bottomX: Double, initC: UIColor, goal: UIColor) -> UIColor{
        let t = (percent - bottomX) / (topX - bottomX)
    
        let cgInit = CGColorGetComponents(initC.CGColor)
        let cgGoal = CGColorGetComponents(goal.CGColor)
    
    
        let r = cgInit[0] + CGFloat(t) * (cgGoal[0] - cgInit[0])
        let g = cgInit[1] + CGFloat(t) * (cgGoal[1] - cgInit[1])
        let b = cgInit[2] + CGFloat(t) * (cgGoal[2] - cgInit[2])
    
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}



