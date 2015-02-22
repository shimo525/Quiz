//
//  AppDelegate.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

var quizArray:[PFObject] = []
var myAccount:[String] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let ID = "UwWG4fMmxYIgF28VRpTj8Ra9gCKD1stNGpvCU0Cf"
        let key = "zz8JpgHARt8KmkYSzQzKlMpUB3feuIrXOZQCCb7M"
        Parse.setApplicationId(ID, clientKey: key)
        PFUser.enableAutomaticUser()
        var defaultACL = PFACL()
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        //quizData
        self.loadQuizData{ (quizes,error) -> () in
            quizArray = quizes
            println("loadedData")
        }
        //accountData
        self.loadAccountData()
        
        return true
    }
    
    //parse
    func loadQuizData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"quiz")
        query.orderByAscending("CreatedAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            callback(objects as [PFObject] ,error)
        }
    }
    
    func loadAccountData(){
        var userDefault = NSUserDefaults.standardUserDefaults()
        if var accountId = userDefault.objectForKey("rfc1034.Quiz.myAccountId") as? String{
        var query:PFQuery = PFQuery(className: "Account")
            query.whereKey("objectId", equalTo:accountId)
            query.selectKeys(["name","passWord"])
            query.findObjectsInBackgroundWithBlock ({(objects:[AnyObject]!, error: NSError!) in
                if(error != nil){
                    println("error")
                }
                let pfObject = objects[0] as PFObject
                myAccount = [pfObject["name"] as String, pfObject["passWord"] as String]
                println("\(myAccount)")
            })
            
        }
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


}

