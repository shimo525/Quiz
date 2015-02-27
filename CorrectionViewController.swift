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
        println("\(myAnswer)")
    }
    
    //UI
    var correctionText:UILabel!
    var messageText1:UILabel!
    var goButton:UIButton!
    
    //parameter
    var originalFrame:CGRect!{
        get{
            return self.view.frame
        }
    }
    var myAnswer:String!
    var correctAnswer:String!

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
        
        messageText1.text = ""
        messageText1.textColor = UIColor.blackColor()
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
