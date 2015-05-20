//
//  AnswerViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/15.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

var answered:Bool!

class AnswerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if answered == true{
            self.navigationController?.popViewControllerAnimated(false)
            answered = false
        }
    }
    
    
    //UI
    var nameLabel:UILabel!
    var contentLabel:UILabel!
    var timeLabel:UILabel!
//    var optionPicker:UIPickerView!
    var optionTable:UITableView!
    var barButtonRight:UIBarButtonItem!
    
    //originalFrame
    var originalFrame:CGRect!{
        get{
            return self.view.frame
        }
    }
    
    //parameter
    var texts:[String]!
    var orderOptions:[String] = []
    var options:[String] = []
    var index:Int = 0
    //time
    var timer:NSTimer!
    var pastSecond:Int = 0
    
    func configure(){
        //UI
        //selfView
//        self.view.backgroundColor = UIColor(red: 1, green: 90/255, blue: 175/255, alpha: 0.2)
//        self.view.backgroundColor = UIColor.grayColor()
        
        //title
        self.navigationItem.title = texts[0]
        
        //nameLabel
        nameLabel = UILabel()
        nameLabel.text = texts[1]
        nameLabel.font = UIFont(name: "Verdana", size: 26)
        nameLabel.sizeToFit()
        nameLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/7.9)
        self.view.addSubview(nameLabel)
        
        //contentLabel
        contentLabel = UILabel(frame: CGRectMake(originalFrame.width/10, 103, (originalFrame.width/5)*4, 60))
        contentLabel.text = texts[2]
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Verdana", size: 20)
        contentLabel.sizeToFit()
        self.view.addSubview(contentLabel)
        
        //timeLabel&timer
        timeLabel = UILabel(frame: CGRectMake(0, 0, 0, 0))
        timeLabel.text = "0"
        timeLabel.font = UIFont(name: "System", size: 25)
        timer = NSTimer(timeInterval: 1.0, target: self, selector:"everySecond", userInfo: nil, repeats: true)
        
        //options
        options = shuffle(orderOptions)

        //optionTable
        optionTable = UITableView(frame: CGRectMake(originalFrame.width/10, 220, (originalFrame.width/5)*4, 200))
        optionTable.delegate = self
        optionTable.dataSource = self
        optionTable.scrollEnabled = false
        optionTable.layer.borderColor = UIColor.blackColor().CGColor
        optionTable.layer.borderWidth = 0.5
        self.view.addSubview(optionTable)
        
        //barButtonRight
        barButtonRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem = barButtonRight
        
    }
    
    //shuffleOptions
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
//        let count = count(list)
        var count1 = count(list)
        for i in 0..<(count1 - 1) {
            let j = Int(arc4random_uniform(UInt32(count1 - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    //timer
    func everySecond(){
        pastSecond += 1
        if pastSecond == 15{
            var alert = UIAlertController(title: "", message: "Oh!! You spent too much time!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:{action in
                self.navigationController?.popViewControllerAnimated(true)
                var n = 0
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            timeLabel.text = pastSecond.description
        }
    }
    
    //answerQuestion
    func done(){
        if let indexPath = self.optionTable.indexPathForSelectedRow(){
            var alert = UIAlertController(title:"", message:"Will you answer this question?", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                answered = true
                var correctionController = self.storyboard?.instantiateViewControllerWithIdentifier("correction") as! CorrectionViewController
                if self.options[indexPath.row] == self.orderOptions[0]{
                    correctionController.correct = true
                }
                else{
                    correctionController.correct = false
                }
                correctionController.correctAnswer = self.orderOptions[0]
                correctionController.index = self.index
                correctionController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
                self.presentViewController(correctionController, animated: true, completion:nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in
            }))
            self.presentViewController(alert, animated: true ,completion: nil)
        }
        else{
            var alert = UIAlertController(title: "", message: "Please choose your answer!!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return orderOptions.count
    }
    
    //tableViewDelegate
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        cell.layer.cornerRadius = 17.5
        cell.layer.borderColor = UIColor.blackColor().CGColor
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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
