//
//  LoginViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/20.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class SignInViewController: UITabBarController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if PFUser.currentUser() != nil{
//            self.performSegueWithIdentifier("LogIn", sender:nil)
            PFUser.logOut()
        }
    }
    var nameText:UITextField!
    var passWordText:UITextField!
    var messageLabel:UILabel!
    var signupButton:UIButton!
    var loginButton:UIButton!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    //MBProgressHUD
    var hud:MBProgressHUD!

    var navigation:UINavigationController!
    
    func configure(){
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        //label
        messageLabel = UILabel()
        messageLabel.textColor = UIColor.redColor()
        messageLabel.font = UIFont(name: "System", size: 14)
        self.view.addSubview(messageLabel)
        
        //backGroundView
        var backGroundView = UIView(frame: CGRectMake(0, 0, (originalFrame.width/5) * 4, originalFrame.height/3.2))
        backGroundView.center = CGPointMake(originalFrame.width/2, originalFrame.height/2.5)
        backGroundView.backgroundColor = UIColor(red: 204/255, green: 238/255, blue: 255/255, alpha: 1)
        backGroundView.layer.cornerRadius = 15
        self.view.addSubview(backGroundView)
        
        //nameTextField
        nameText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/3.7, originalFrame.width/1.5, 40))
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.backgroundColor = UIColor.whiteColor()
        nameText.delegate = self
        self.view.addSubview(nameText)
        
        //passWordTextField
        passWordText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/2.7, originalFrame.width/1.5, 40))
        passWordText.borderStyle = UITextBorderStyle.Bezel
        passWordText.backgroundColor = UIColor.whiteColor()
        passWordText.delegate = self
        self.view.addSubview(passWordText)
        
        //signButtons
        signupButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signupButton.frame = CGRectMake((originalFrame.width/2) - 30, originalFrame.height/2.2, 60, 60)
        signupButton.setTitle("signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        signupButton.layer.cornerRadius = 30
        signupButton.backgroundColor = UIColor.whiteColor()
        signupButton.addTarget(self, action: "sign", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
    }
    
    func progressHud(){
        //MBProgressHUD
        self.hud = MBProgressHUD(view: self.view)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeIndeterminate
        hud.labelText = "Loading"
        self.view.addSubview(hud)
    }
    
    func sign(){
        if (nameText.text != "")&&(passWordText.text != ""){
            progressHud()
            var account = PFUser()
            account.username = nameText.text
            account.password = passWordText.text
            // Check already registerd user
            var checkExist = PFUser.query()
            checkExist.whereKey("username", equalTo: account.username)
            checkExist.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
                    if(objects.count > 0){
                        self.signIn(account.username, password:account.password)
                    }
                    else{
                        self.messageLabel.text = "Wrong password!!"
                        self.messageLabel.sizeToFit()
                        self.messageLabel.center = CGPointMake(self.originalFrame.width/2, self.originalFrame.height/1.7)
                        self.hud.hide(true, afterDelay: 0.3)
                }
            }
        }
        else{
            messageLabel.text = "Please fill in the blank!!"
        }
        messageLabel.sizeToFit()
        messageLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/1.7)
    }
    
    
    func signIn(username:NSString, password:NSString) {
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("LogIn", sender: nil)
            } else {
                self.messageLabel.text = "Wrong password!!"
                self.messageLabel.sizeToFit()
                self.messageLabel.center = CGPointMake(self.originalFrame.width/2, self.originalFrame.height/1.7)
                
            }
            self.hud.hide(true, afterDelay: 0.3)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("\(PFUser.currentUser().username)")
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
