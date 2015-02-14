//
//  CreateViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit
import Parse

class CreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var contentText:UITextField!
    var choices:UIPickerView!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //title
        
        
        //contents
        contentText = UITextField(frame: CGRectMake(0, 0, originalFrame.width/1.2, originalFrame.height/5))
        contentText.text = ""
        contentText.textAlignment = NSTextAlignment.Center
        contentText.sizeToFit()
        self.view.addSubview(contentText)
    }
    
    func save(){
        var obj:PFObject
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
