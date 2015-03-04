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
    //UI
    var nameText:UITextField!
    var passWordText:UITextField!
    var signupButton:UIButton!
    var facebookButton:UIButton!
    
    //parameter
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    //MBProgressHUD
    var hud:MBProgressHUD!
    
    func configure(){
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        //backGroundView
        var backGroundView = UIView(frame: CGRectMake(originalFrame.width/10, 142, (originalFrame.width/5) * 4, 207))
        backGroundView.backgroundColor = UIColor(red: 204/255, green: 238/255, blue: 255/255, alpha: 1)
        backGroundView.layer.cornerRadius = 15
        self.view.addSubview(backGroundView)
        
        //nameTextField
        nameText = UITextField(frame: CGRectMake(originalFrame.width/6, 164, originalFrame.width/1.5, originalFrame.height/13))
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.backgroundColor = UIColor.whiteColor()
        nameText.delegate = self
        nameText.placeholder = "username"
        self.view.addSubview(nameText)
        
        //passWordTextField
        passWordText = UITextField(frame: CGRectMake(originalFrame.width/6, 218, originalFrame.width/1.5, originalFrame.height/13))
        passWordText.borderStyle = UITextBorderStyle.Bezel
        passWordText.backgroundColor = UIColor.whiteColor()
        passWordText.delegate = self
        passWordText.placeholder = "password"
        self.view.addSubview(passWordText)
        
        //signButton
        signupButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signupButton.frame = CGRectMake((originalFrame.width/12)*5, 276, originalFrame.width/6, originalFrame.width/6)
        signupButton.setTitle("signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signupButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        signupButton.layer.cornerRadius = originalFrame.width/12
        signupButton.layer.borderColor = UIColor.blackColor().CGColor
        signupButton.backgroundColor = UIColor.whiteColor()
        signupButton.addTarget(self, action: "sign", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signupButton)
        
        //facebookLabel
        var facebookLabel = UILabel()
        facebookLabel.text = "or you can sign up with..."
        facebookLabel.textColor = UIColor.blackColor()
        facebookLabel.sizeToFit()
        facebookLabel.center = CGPointMake(originalFrame.width/2, 382)
        self.view.addSubview(facebookLabel)
        
        //facebookButton
        facebookButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        facebookButton.frame = CGRectMake(originalFrame.width/6, 405, originalFrame.width/1.5, originalFrame.height/10.4)
        facebookButton.setTitle("FaceBook", forState: UIControlState.Normal)
        facebookButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        facebookButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        facebookButton.layer.borderColor = UIColor.blackColor().CGColor
        self.view.addSubview(facebookButton)
        
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
                        var alert = UIAlertController(title:"", message:"Wrong password!!", preferredStyle:UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                        }))
                        self.presentViewController(alert, animated:true ,completion:nil)
                        self.hud.hide(true, afterDelay: 0.3)
                }

            }
        }
        else{
            var alert = UIAlertController(title:"", message:"Please fill in the blank!!", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            }))
            self.presentViewController(alert, animated:true ,completion:nil)
        }
    }
    
    
    func signIn(username:NSString, password:NSString) {
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("LogIn", sender: nil)
            } else {
                var alert = UIAlertController(title:"", message:"Wrong password!!", preferredStyle:UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                }))
                self.presentViewController(alert, animated:true ,completion:nil)
                
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
