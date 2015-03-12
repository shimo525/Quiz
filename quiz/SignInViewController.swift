//
//  LoginViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/20.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit


class SignInViewController: UIViewController,UITextFieldDelegate,FBLoginViewDelegate {

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
    //UI
    var nameText:UITextField!
    var passWordText:UITextField!
    var signButton:UIButton!
    var facebookButton:FBLoginView!
    
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
        
        //gestureRecognizer
        var gesture = UITapGestureRecognizer(target: self, action: "closeKeyboard")
        self.view.addGestureRecognizer(gesture)
        
        //nameTextField
        nameText = UITextField(frame: CGRectMake(originalFrame.width/6, 164, originalFrame.width/1.5, originalFrame.height/13))
        nameText.borderStyle = UITextBorderStyle.Bezel
        nameText.backgroundColor = UIColor.whiteColor()
        nameText.delegate = self
        nameText.clearButtonMode = UITextFieldViewMode.Always
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
        signButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signButton.frame = CGRectMake((originalFrame.width/12)*5, 276, originalFrame.width/6, originalFrame.width/6)
        signButton.setTitle("signin", forState: UIControlState.Normal)
        signButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        signButton.layer.cornerRadius = originalFrame.width/12
        signButton.layer.borderColor = UIColor.blackColor().CGColor
        signButton.backgroundColor = UIColor.whiteColor()
        signButton.addTarget(self, action: "sign", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signButton)
    
        
        //facebookLabel
        var facebookLabel = UILabel()
        facebookLabel.text = "or you can sign in with..."
        facebookLabel.textColor = UIColor.blackColor()
        facebookLabel.sizeToFit()
        facebookLabel.center = CGPointMake(originalFrame.width/2, 382)
        self.view.addSubview(facebookLabel)
        
        //facebookButton
        facebookButton = FBLoginView()
        facebookButton.frame = CGRectMake(originalFrame.width/6, 405, originalFrame.width/1.5, originalFrame.height/10.4)
        facebookButton.delegate = self
        self.view.addSubview(facebookButton)
        
    }
    
    func progressHud(){
        //MBProgressHUD
        self.hud = MBProgressHUD(view: self.view)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
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
//            checkExist.whereKey("password", equalTo: account.password)
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

    func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(PFUser.currentUser().objectId, forKey: "userData")
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
    
    //FBLoginViewDelegate
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        let str = user.objectForKey("Email") as String?
        println("\(str)")
//        println("a")
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
