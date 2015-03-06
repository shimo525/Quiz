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
    var correctionText:UILabel!
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
        
        //correctionText
        correctionText = UILabel()
        correctionText.text = correctAnswer
        correctionText.textColor = UIColor.blackColor()
        correctionText.sizeToFit()
        correctionText.center = CGPointMake(originalFrame.width/2, 50)
        self.view.addSubview(correctionText)
        
        //messageText1
        messageText1 = UILabel()
        if correct == true{
            messageText1.text = "Congratulations!!!"
        }
        else{
            messageText1.text = "Oh No!"
        }
        messageText1.sizeToFit()
        messageText1.center = CGPointMake(originalFrame.width/2, 80)
        messageText1.textColor = UIColor.blackColor()
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
        messageText2.center = CGPointMake(originalFrame.width/2, 100)
        messageText2.textColor = UIColor.blackColor()
        
        //button
        goButton = UIButton()
        goButton.setTitle("back", forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        goButton.addTarget(self, action: "goBack", forControlEvents: UIControlEvents.TouchUpInside)
        goButton.layer.borderColor = UIColor.blackColor().CGColor
        goButton.sizeToFit()
        goButton.center = CGPointMake(originalFrame.width/2, 150)
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
        /*
        let index = self.navigationController?.viewControllers.count
        var previousController = self.navigationController?.viewControllers[index! - 1] as UIViewController
        self.navigationController?.popToViewController(previousController, animated: true)*/
        println("\(self.navigationController?.viewControllers[0])")
        println("\(self.navigationController?.viewControllers[1])")
        println("\(self.navigationController?.viewControllers)")
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
