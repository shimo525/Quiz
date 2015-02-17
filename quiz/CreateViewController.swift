//
//  CreateViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit


class CreateViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var titleText:UITextField!
    var contentText:UITextField!
    var choices:UIPickerView!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //titleBar
        self.title = "Create"
        
        //titleText
        titleText = UITextField(frame: CGRectMake(originalFrame.height/1.1, originalFrame.height/2, originalFrame.width/1.7, originalFrame.height/10))
        
        //contentText
        contentText = UITextField(frame: CGRectMake(originalFrame.width/1.4, originalFrame.height/5,originalFrame.width/1.2,originalFrame.height/5))
        contentText.text = ""
        contentText.textAlignment = NSTextAlignment.Center
        self.view.addSubview(contentText)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
