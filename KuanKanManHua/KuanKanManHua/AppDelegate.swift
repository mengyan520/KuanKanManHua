//
//  AppDelegate.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/7.
//  Copyright © 2016年 mm. All rights reserved.



import UIKit
import JPFPSStatus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  
    var tabbarController:MainTabBarViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        tabbarController = MainTabBarViewController()
        window?.rootViewController = tabbarController
        changeToMainPage()
        window?.makeKeyAndVisible()
        NotificationCenter.default.addObserver(self, selector: #selector(self.login), name: NSNotification.Name.init(rawValue: "login"), object: nil)
        SQLiteManager.sharedManager.createTable(name: "history")
        JPFPSStatus.sharedInstance().open()
        
        return true
    }
    //MARK:- 控制器
    func changeToMainPage () {
        
       let backgroundImage = UIImage.init(named: "Tabbar-Bg_2x45_")
        tabbarController?.addChildVc(arrVC: [HomeViewController(),DiscoverViewController(),CommunityViewController(), MeTableViewController()])
        tabbarController?.BaseTabBarItem(titles: ["首页","发现","v社区","我的"], Font: Font(fontSize: 14), titleColor:BLACK_COLOR, selectedTitleColor: BLACK_COLOR, images:["ic_tabbar_home_normal_30x30_","ic_tabbar_discover_normal_30x30_","ic_tabbar_media_normal_30x30_","ic_tabbar_me_normal_30x30_"], selectedImages:["ic_tabbar_home_pressed_30x30_","ic_tabbar_discover_pressed_30x30_","ic_tabbar_media_pressed_30x30_","ic_tabbar_me_pressed_30x30_"], barBackgroundImage: backgroundImage)
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
   //通知方法
    func login() {
        if !MMUtils.userHasLogin() {
        let controller =    tabbarController?.selectedViewController
       
        controller?.present(UINavigationController.init(rootViewController: LoginViewController()), animated: true, completion: nil)
                
            
        }
    }
}

