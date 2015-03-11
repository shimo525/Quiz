//
//  FirstViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/03/03.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class FirstTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var tabHeight = self.tabBar.frame.height
        var naviHeight = self.navigationController?.navigationBar.frame.height
        var naviY = self.navigationController?.navigationBar.frame.minY
        self.tabBar.frame = CGRectMake(0, naviHeight! + naviY!, windowSize.width, tabHeight)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 90/255, blue: 175/255, alpha: 0.7)
        println("\(self.navigationController?.navigationBar.frame)")
        println("\(self.tabBar.frame)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
