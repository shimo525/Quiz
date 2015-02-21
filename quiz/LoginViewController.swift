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
    var messageLabel:UILabel!
    var signButton:UIButton!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    var userDefault:NSUserDefaults!
    
    func configure(){
        //myName
        userDefault = NSUserDefaults.standardUserDefaults()
        if let name = userDefault.objectForKey("rfc1034.quiz.myName") as? String{
            myName = name
        }
        
        //labels
        var helloLabel = UILabel()
        helloLabel.text = "Welcome To Questioning!!"
        helloLabel.font = UIFont(name: "Zapfino", size: 18)
        helloLabel.sizeToFit()
        helloLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/10)
        self.view.addSubview(helloLabel)
        
        var orderLabel = UILabel()
        if myName == nil{
            orderLabel.text = "Please Sign Up!!"
        }
        else{
            orderLabel.text = "Please Sign In!!"
        }
        orderLabel.sizeToFit()
        orderLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/7)
        self.view.addSubview(orderLabel)
        
        messageLabel = UILabel()
        messageLabel.text = ""
        messageLabel.center = CGPointMake(originalFrame.width, originalFrame.height/1.6)
        
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        //backGroundView
        var backGroundView = UIView(frame: CGRectMake(originalFrame.width/8, originalFrame.height/4, (originalFrame.width/4) * 3, originalFrame.height/2.2))
        
        backGroundView.backgroundColor = UIColor(red: 204/255, green: 238/255, blue: 255/255, alpha: 1)
        self.view.addSubview(backGroundView)
        
        //nameTextField
        nameText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/3, originalFrame.width/1.5, 40))
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.backgroundColor = UIColor.whiteColor()
        nameText.delegate = self
        self.view.addSubview(nameText)
        
        //passWordTextField
        passWordText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/2.3, originalFrame.width/1.5, 40))
        passWordText.borderStyle = UITextBorderStyle.Bezel
        passWordText.backgroundColor = UIColor.whiteColor()
        passWordText.delegate = self
        self.view.addSubview(passWordText)
        
        //signButton
        signButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signButton.frame = CGRectMake(originalFrame.width/1.4, originalFrame.height/6, originalFrame.width/5, 40)
        if myName == nil{
                signButton.setTitle("SignUp", forState: UIControlState.Normal)
        }
        else{
             signButton.setTitle("SignIn", forState: UIControlState.Normal)
        }
        signButton.addTarget(self, action: "sign", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signButton)
        
        
    }
    
    func sign(){
        if (nameText.text != "")&&(passWordText.text != ""){
            
        }
        else{
            messageLabel.text = "Please fill in the blank!!"
            messageLabel.sizeToFit()
        }
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
