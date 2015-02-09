//
//  ViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit
import Parse

class TimeLineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configure(){
        //parseData
        self.loadData{ (pictures,error) -> () in
        }
    }
    
    func loadData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"userName")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{}
            callback(objects as [PFObject] ,error)
        }
        
    }

}

