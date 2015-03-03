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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(){
        /*if (nameText.text != "")&&(passWordText.text != ""){
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
                if(objects.count > 0){
                    self.messageLabel.text = "This username is already used."
                    self.hud.hide(true, afterDelay: 0.3)
                }
                else{
                    self.signUp(account)
                }
            }
        }
        else{
            messageLabel.text = "Please fill in the blank!!"
        }
        messageLabel.sizeToFit()
        messageLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/1.7)*/
    }
        func signUp(tweeter:PFUser) {
            tweeter.signUpInBackgroundWithBlock{
                (success:Bool!, error:NSError!)->Void in
                if error != nil{
                    println("Sign up succeeded.")
                    self.performSegueWithIdentifier("LogIn", sender: nil)
                }else{
/*                    self.messageLabel.text = "Error occured."
                    self.messageLabel.sizeToFit()
                    self.messageLabel.center = CGPointMake(self.originalFrame.width/2, self.originalFrame.height/1.7)*/
                }
//                self.hud.hide(true, afterDelay: 0.3)
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
