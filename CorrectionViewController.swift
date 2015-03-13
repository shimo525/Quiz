//
//  CorrectionViewController.swift
//  
//
//  Created by 下馬場光祐 on 2015/02/27.
//
//

import UIKit

class CorrectionViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
    
    //UI
    var correctionTexr1:UILabel!
    var correctionText2:UILabel!
    var messageText1:UILabel!
    var messageText2:UILabel!
    var goButton:UIButton!
    
    //parameter
    var originalFrame:CGRect!{
        get{
            return self.view.frame
        }
    }
    var correct:Bool!
    var correctAnswer:String!
    var index:Int!
    
    func configure(){
        //selfView
        self.view.backgroundColor = UIColor.whiteColor()
        
        //corrctionText1
        correctionTexr1 = UILabel()
        correctionTexr1.text = "The correct answer is ..."
        correctionTexr1.textColor = UIColor.blackColor()
        correctionTexr1.sizeToFit()
        correctionTexr1.center = CGPointMake(originalFrame.width/2,30)
        self.view.addSubview(correctionTexr1)
        
        //correctionText2
        correctionText2 = UILabel()
        correctionText2.text = "\(correctAnswer)"
        correctionText2.textColor = UIColor.blackColor()
        correctionText2.sizeToFit()
        correctionText2.center = CGPointMake(originalFrame.width/2, 70)
        self.view.addSubview(correctionText2)
        
        //messageText1
        messageText1 = UILabel()
        if correct == true{
            messageText1.text = "Congratulations!!!"
        }
        else{
            messageText1.text = "Oh No!"
        }
        messageText1.font = UIFont(name: "Verdana", size: 35)
        messageText1.sizeToFit()
        messageText1.center = CGPointMake(originalFrame.width/2, 100)
        messageText1.textColor = UIColor.redColor()
        self.view.addSubview(messageText1)
        
        //messageText1
        messageText2 = UILabel()
        if correct == true{
            messageText2.text = "You chose right answer!!"
        }
        else{
            messageText2.text = "You chose wrong answer!"
        }
        messageText2.sizeToFit()
        messageText2.center = CGPointMake(originalFrame.width/2, 140)
        messageText2.textColor = UIColor.blackColor()
        self.view.addSubview(messageText2)
        
        //button
        goButton = UIButton()
        goButton.setTitle("back", forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        goButton.addTarget(self, action: "goBack", forControlEvents: UIControlEvents.TouchUpInside)
        goButton.layer.borderColor = UIColor.blackColor().CGColor
        goButton.sizeToFit()
        goButton.center = CGPointMake(originalFrame.width/2, 230)
        self.view.addSubview(goButton)
        
        if correct == true{
            correctionNumber()
        }
    }
    
    func correctionNumber(){
        var quizObj = quizArray[index]
        quizObj.incrementKey("correction")
        var query:PFQuery = PFQuery(className: "quiz")
    }
    
    func goBack(){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
//        let viewControllers = self.navigationController?.viewControllers[0] as UINavigationController
//        self.navigationController?.popToViewController(viewControllers, animated: true)
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
