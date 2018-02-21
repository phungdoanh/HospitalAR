//
//  AppDelegate.swift
//  HospitalAR
//
//  Created by Peter Andringa on 2/5/18.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // TEMP: Stub a clue for Realm
        let clueRealm = try! Realm()
        if clueRealm.objects(Clue.self).count == 0 {
            let testClue = Clue()
            testClue.id = 1
            testClue.clueTitle = "Clue #1"
            testClue.clueText = "You want to fly? You’re looking for birds with long necks who honk when they're flying."
            testClue.hint = "These geese are flying towards treatment!"
            testClue.image = "cape.jpg"
            testClue.foundTitle = "Cape"
            testClue.foundText = "You found a cape! Your hero now has the power of flight."
        
            try! clueRealm.write {
                clueRealm.add(testClue)
            }
        }
        return true
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


}

