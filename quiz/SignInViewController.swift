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
            self.performSegueWithIdentifier("LogIn", sender:nil)
//            PFUser.logOut()
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
//        self.win
        
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
        signupButton.frame = CGRectMake((originalFrame.width/2) - 80, originalFrame.height/2.2, 60, 60)
        signupButton.setTitle("signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        signupButton.layer.cornerRadius = 30
        signupButton.backgroundColor = UIColor.whiteColor()
        signupButton.tag = 1
        signupButton.addTarget(self, action: "sign:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
        loginButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        loginButton.frame = CGRectMake((originalFrame.width/2) + 20, originalFrame.height/2.2, 60, 60)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        loginButton.layer.cornerRadius = 30
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.tag = 2
        loginButton.addTarget(self, action: "sign:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton)
        
        
    }
    
    func progressHud(){
        //MBProgressHUD
        self.hud = MBProgressHUD(view: self.view)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeIndeterminate
        hud.labelText = "Loading"
        self.view.addSubview(hud)
    }
    
    func sign(sender:UIButton){
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
                if sender.tag == 1{
                    if(objects.count > 0){
                        self.messageLabel.text = "This username is already used."
                        self.hud.hide(true, afterDelay: 0.3)
                    }
                    else{
                        self.signUp(account)
                    }
                }else if sender.tag == 2{
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
    
    func signUp(tweeter:PFUser) {
        tweeter.signUpInBackgroundWithBlock{
            (success:Bool!, error:NSError!)->Void in
            if error != nil{
                println("Sign up succeeded.")
                self.performSegueWithIdentifier("LogIn", sender: nil)
            }else{
                self.messageLabel.text = "Error occured."
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
