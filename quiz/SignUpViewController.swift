//
//  SignUpViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/03/03.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class SignUpViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure(){
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    //UI
    var nameText:UITextField!
    var passWordText:UITextField!
    var signupButton:UIButton!
    
    //parameter
    var hud:MBProgressHUD!
    
    
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
                        self.hud.hide(true, afterDelay: 0.3)
                        var alert = UIAlertController(title:"", message:"this username is already used.", preferredStyle:UIAlertControllerStyle.Alert)
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
                if error != nil{
                    println("Sign up succeeded.")
                    self.performSegueWithIdentifier("LogIn", sender: nil)
                }else{
                    var alert = UIAlertController(title:"", message:"Wrong password!!", preferredStyle:UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                    }))
                    self.presentViewController(alert, animated:true ,completion:nil)
                }
                self.hud.hide(true, afterDelay: 0.3)
            }
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
