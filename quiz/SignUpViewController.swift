//
//  SignUpViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/03/03.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

//                backGroundView.backgroundColor = UIColor(red: 1, green: 196/255, blue: 155/255, alpha: 1)
        configure()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UI
    var nameText:UITextField!
    var passWordText:UITextField!
    var signButton:UIButton!
    
    //parameter
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    var hud:MBProgressHUD!
    
    func configure(){
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        var imageView = UIImageView(frame:CGRectMake(-80, 0, originalFrame.width + 160, originalFrame.height))
        imageView.image = UIImage(named: "模様.gif")
        imageView.layer.cornerRadius = 7
        self.view.addSubview(imageView)
        
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
        passWordText.clearButtonMode = UITextFieldViewMode.Always
        passWordText.placeholder = "password"
        passWordText.secureTextEntry = true
        self.view.addSubview(passWordText)
        
        //signButton
        signButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signButton.frame = CGRectMake((originalFrame.width/12)*5, 285, originalFrame.width/6, originalFrame.width/6)
        signButton.setTitle("signup", forState: UIControlState.Normal)
        signButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        signButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        signButton.backgroundColor = UIColor.clearColor()
        signButton.setBackgroundImage(UIImage(named: "Button3.gif"), forState: UIControlState.Normal)
        signButton.layer.cornerRadius = originalFrame.width/10
        signButton.layer.borderColor = UIColor.blackColor().CGColor
        signButton.addTarget(self, action: "sign", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(signButton)
        

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
            self.progressHud()
            var account = PFUser()
            account.username = self.nameText.text
            account.password = self.passWordText.text
            // Check already registerd user
            var checkExist = PFUser.query()
            checkExist.whereKey("username", equalTo: account.username)
            checkExist.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if(objects.count > 0){
                    self.hud.hide(true, afterDelay: 0.3)
                    var alert = UIAlertController(title:"", message:"This username is already used.", preferredStyle:UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                    }))
                    self.presentViewController(alert, animated:true ,completion:nil)
                    self.hud.hide(true, afterDelay: 0.3)
                }
                else{
                    self.signUp(account)
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

    
    func signUp(tweeter:PFUser) {
        tweeter.signUpInBackgroundWithBlock{
            (success:Bool!, error:NSError!)->Void in
            if error == nil{
                println("Sign up succeeded.")
                self.performSegueWithIdentifier("LogIn", sender: nil)
            }else{
            var alert = UIAlertController(title:"", message:"Error occcured!!", preferredStyle:UIAlertControllerStyle.Alert)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
