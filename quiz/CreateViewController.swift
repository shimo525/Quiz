//
//  CreateViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/09.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit


class CreateViewController: UIViewController,UITextFieldDelegate{

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
    var messageLabel:UILabel!
    var originalFrame:CGRect!{
        get {
            return self.view.frame
        }
    }
    
    func configure(){
        //selfview
//        self.view.backgroundColor = UIColor.grayColor()
//        self.view.backgroundColor = UIColor(red: 1, green: 90/255, blue: 175/255, alpha: 0.2)
        
        //titleBar
        self.navigationItem.title = "Create"
        
        //titleText
        let nav = self.navigationController?.navigationBar.frame.minY
        titleText = UITextField(frame: CGRectMake(originalFrame.width/6, originalFrame.height/9, originalFrame.width/1.5, 35))
        titleText.borderStyle = UITextBorderStyle.Bezel
        titleText.layer.backgroundColor = UIColor.whiteColor().CGColor
        titleText.placeholder = "Title"
//        titleText.delegate = self
        self.view.addSubview(titleText)
        
        //contentText
        contentText = UITextView(frame: CGRectMake(originalFrame.width/10, titleText.frame.maxY + 5, (originalFrame.width/5)*4, 80))
        contentText.layer.backgroundColor = UIColor.whiteColor().CGColor
        contentText.layer.borderColor = UIColor.blackColor().CGColor
        contentText.layer.borderWidth = 0.5
        contentText.font = UIFont(name: "Verdana", size: 15)
        self.view.addSubview(contentText)
        
        //choicesText
        for l in 0...3{
            var choiceText = UITextField()
            choiceText.frame = CGRectMake(originalFrame.width/6, contentText.frame.maxY + 5 + 35 * CGFloat(l), originalFrame.width/1.5, 35)
            choiceText.borderStyle = UITextBorderStyle.Bezel
//            choiceText.delegate = self
            choiceText.layer.backgroundColor = UIColor.whiteColor().CGColor
            choiceText.placeholder = "Choice\(l+1)"
            choiceTexts.append(choiceText)
            self.view.addSubview(choiceText)
        }
        
        //explainLabel
        var explainLabel = UILabel(frame: CGRectMake(originalFrame.width/14, contentText.frame.maxY + 150, (originalFrame.width/7)*6, 60))
        explainLabel.text = "First answer will be the right answer of this question!!"
        explainLabel.textColor = UIColor.blackColor()
        explainLabel.numberOfLines = 0
        explainLabel.font = UIFont(name: "Verdana", size: 12)
        explainLabel.sizeToFit()
//        explainLabel.center = CGPointMake(originalFrame.width/2, contentText.frame.maxY + 155)
        self.view.addSubview(explainLabel)
        
        
        //messageLabel
        messageLabel = UILabel(frame: CGRectMake(originalFrame.width/14, contentText.frame.maxY + 190,(originalFrame.width/7)*6, 30))
        messageLabel.text = "Please create at least two choices!!"
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.font = UIFont(name: "Verdata", size: 12)
        messageLabel.sizeToFit()
        self.view.addSubview(messageLabel)
        
        //barButtonRight
        rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done , target: self, action: "save")
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    func save(){
        if (titleText.text != "")&&(contentText.text != "")&&(choiceTexts[0].text != "")&&(choiceTexts[1].text != ""){
        var object:PFObject = PFObject(className: "quiz")
        object["name"] = PFUser.currentUser().username
        object["userID"] = PFUser.currentUser().objectId
        object["title"] = titleText.text
        object["content"] = contentText.text
        object["correction"] = 0
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
        }
        else if (choiceTexts[0] == "")||(choiceTexts[1] == ""){
            var alert = UIAlertController(title:"", message:"Corerct answer should be only one!!", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            }))
            self.presentViewController(alert, animated:true ,completion:nil)
        }
        else if (choiceTexts[0] == choiceTexts[1])||(choiceTexts[0] == choiceTexts[2])||(choiceTexts[0] == choiceTexts[3]){
            var alert = UIAlertController(title:"", message:"Correct answer should be only one!!", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            }))
            self.presentViewController(alert, animated:true ,completion:nil)
        }
        else{
            var alert = UIAlertController(title:"", message:"Please fill in the blank!!", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            }))
            self.presentViewController(alert, animated:true ,completion:nil)
        }
    }
    
//    func text
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
