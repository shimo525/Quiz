//
//  CreateViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit


class CreateViewController: UIViewController{

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
    var rightButton:UIBarButtonItem!
    var choiceTexts:[UITextField] = []
    var messagaLabel:UILabel!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //selfview
        self.view.backgroundColor = UIColor.grayColor()
        
        //titleBar
        self.navigationItem.title = "Create"
        
        //titleText
        let nav = self.navigationController?.navigationBar.frame.minY
        titleText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/9, originalFrame.width/1.5, 35))
        titleText.borderStyle = UITextBorderStyle.Bezel
        titleText.layer.backgroundColor = UIColor.whiteColor().CGColor
//        titleText.delegate = self
        self.view.addSubview(titleText)
        
        //contentText
        contentText = UITextView(frame: CGRectMake(0, titleText.frame.maxY + 5, originalFrame.width, originalFrame.height/6))
        contentText.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.view.addSubview(contentText)
        
        //choicesText
        for l in 0...3{
            var choiceText = UITextField()
            choiceText.frame = CGRectMake(originalFrame.width/6, contentText.frame.maxY + 5 + 35 * CGFloat(l), originalFrame.width/1.5, 35)
            choiceText.borderStyle = UITextBorderStyle.Bezel
//            choiceText.delegate = self
            choiceText.layer.backgroundColor = UIColor.whiteColor().CGColor
            choiceTexts.append(choiceText)
            self.view.addSubview(choiceText)
        }
        
        //messageLabel
        messagaLabel = UILabel()
        messagaLabel.text = "Please create at least two choices!!"
        messagaLabel.textColor = UIColor.redColor()
        messagaLabel.font = UIFont(name: "System", size: 14)
        messagaLabel.sizeToFit()
        messagaLabel.center = CGPointMake(originalFrame.width/2, contentText.frame.maxY + 155)
        self.view.addSubview(messagaLabel)
        
        //barButtonRight
        rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: "save")
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    func save(){
        if (titleText.text != "")&&(contentText.text != ""){
        var object:PFObject = PFObject(className: "quiz")
        object["name"] = PFUser.currentUser().username
        object["userID"] = PFUser.currentUser().objectId
        object["title"] = titleText.text
        object["content"] = contentText.text
        for l in 0...3{
            if choiceTexts[l].text != ""{
                object["choice\(l)"] = choiceTexts[l].text
            }
            else{
                break
            }
        }
        object.save()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }else{
            var actionSheet:UIActionSheet
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
