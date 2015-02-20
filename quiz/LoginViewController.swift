//
//  LoginViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/20.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class LoginViewController: UITabBarController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        println("login")
        // Do any additional setup after loading the view.
    }
    
    var nameText:UITextField!
    var passWordText:UITextField!
    var loginButton:UIButton!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //myName
        var userDefault = NSUserDefaults.standardUserDefaults()
        if let name = userDefault.objectForKey("rfc1034.quiz.myName") as? String{
            myName = name
        }
        
        //labels
        var helloLabel = UILabel()
        helloLabel.text = "Welcome To myQuiz!!"
        helloLabel.font = UIFont(name: "Zapfino", size: 18)
        helloLabel.sizeToFit()
        helloLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/10)
        self.view.addSubview(helloLabel)
        
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        //nameTextField
        nameText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/7.5, originalFrame.width/1.5, 40))
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.delegate = self
        self.view.addSubview(nameText)
        
        //passWordTextField
        passWordText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/5, originalFrame.width/1.5, 40))
        passWordText.borderStyle = UITextBorderStyle.Bezel
        passWordText.delegate = self
        self.view.addSubview(passWordText)
        
        //loginButton
        loginButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        loginButton.frame = CGRectMake(originalFrame.width/6, originalFrame.height/3.5, originalFrame.width/1.5, 40)
        loginButton.setTitle("LogIn", forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
        
        
        
    }
    
    func login(){
        
    }
    
    //textFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
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
