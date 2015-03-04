//
//  TabBarController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/19.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

protocol RefreshButton{
    func refresh()
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //barButtonRight
        barButtonRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action:"add")
        self.navigationItem.rightBarButtonItem = barButtonRight
        
        //barButtonLeft
        barButtonLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "reload")
        self.navigationItem.leftBarButtonItem = barButtonLeft
        
    }
    
    var barButtonRight:UIBarButtonItem!
    var barButtonLeft:UIBarButtonItem!
    var refreshDelegate:RefreshButton!
    
    func reload(){
        refreshDelegate.refresh()
    }
    
    func add(){
        self.performSegueWithIdentifier("Create", sender: nil)
    }
    
    
/*
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
