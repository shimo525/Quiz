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
        /*var contentView = self.tabBar.subviews[0] as UIView
        contentView.frame = CGRectMake(0, tabHeight, windowSize.width, windowSize.height - tabHeight)*/
        // Do any additional setup after loading the view.
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
