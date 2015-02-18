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
    var contentText:UITextView!
    var choices:UIPickerView!
    var rightButton:UIBarButtonItem!
    
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //titleBar
        self.navigationItem.title = "Create"
        
        //titleText
        titleText = UITextField(frame: CGRectMake(originalFrame.height/1.1, originalFrame.height/2, originalFrame.width/1.7, originalFrame.height/10))
        
        //contentText
        contentText = UITextView(frame: CGRectMake(originalFrame.width/1.4, originalFrame.height/5,originalFrame.width/1.2,originalFrame.height/5))
        self.view.addSubview(contentText)
        
        //barButtonRight
        rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: "save")
        self.navigationItem.rightBarButtonItem = rightButton
        
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
