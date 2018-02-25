//
//  AppDelegate.swift
//  HospitalAR
//
//  Created by Peter Andringa on 2/5/18.
//

import UIKit
import RealmSwift

protocol RealmRetriever {
    func getRealm(cb: @escaping (Realm) -> Void)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RealmRetriever {

    var window: UIWindow?

    var clueRealm: Realm?
    
    var realmCallbacks = [(Realm) -> Void]()
    
    func logIn(done: @escaping (SyncUser) -> Void) {
        let usernameCredentials = SyncCredentials.usernamePassword(username: "hospitalar", password: "w4Uyhz9e=")
        SyncUser.logIn(with: usernameCredentials, server: URL(string: "http://ec2-52-91-169-138.compute-1.amazonaws.com:9080")!) { user, error in
            if let user = user {
                done(user)
            } else if let error = error {
                print("Error logging in")
                print(error)
            }
        }
    }
        
    func openRealm(user: SyncUser, done: @escaping (Realm) -> Void)  {
        let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://ec2-52-91-169-138.compute-1.amazonaws.com:9080/clues")!))
        Realm.asyncOpen(configuration: config) { realm, error in
            if let realm = realm {
                done(realm)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func getRealm(cb: @escaping (Realm) -> Void) {
        if let realm = self.clueRealm {
            cb(realm)
        } else {
            realmCallbacks.append(cb)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.realmCallbacks.append { realm in
            print("Successfully loaded realm")
        }
        
        // TEMP: Stub a clue for Realm
        self.logIn() { user in
            print("Logged in")
            self.openRealm(user: user) { realm in
                print("Opened Realm")
                self.clueRealm = realm
                for cb in self.realmCallbacks { cb(realm) }
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

