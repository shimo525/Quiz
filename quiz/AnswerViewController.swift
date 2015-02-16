//
//  AnswerViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/15.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit
import Parse

class AnswerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    //sent items
    var nameText:String?
    var titleText:String?
    var contentText:String?
    var options:[String]?
    
    func configure(){
        
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
