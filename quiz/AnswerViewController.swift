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
    var index:Int!
    
    func configure(){
        //UI
        //title
        self.title = texts[0]
        
        //nameLabel
        nameLabel = UILabel()
        nameLabel.text = texts[1]
        nameLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/8)
        nameLabel.sizeToFit()
        self.view.addSubview(nameLabel)
        
        //contentLabel
        contentLabel = UILabel()
        contentLabel.text = texts[2]
        contentLabel.center = CGPointMake(originalFrame.width/2, originalFrame.height/6)
        contentLabel.sizeToFit()
        self.view.addSubview(contentLabel)
        
        //options
        options = shuffle(orderOptions)
        
        //opitonPicker
        /*optionPicker = UIPickerView(frame: CGRectMake((originalFrame.width - 100)/2, originalFrame.height/2, 100, originalFrame.height/10))
        optionPicker.dataSource = self
        optionPicker.delegate = self
        self.view.addSubview(optionPicker)*/
        
        //optionTable
        optionTable = UITableView(frame: CGRectMake(originalFrame.width/10, 200, (originalFrame.width/5)*4, 140))
        optionTable.delegate = self
        optionTable.dataSource = self
        optionTable.scrollEnabled = false
        optionTable.layer.borderColor = UIColor.blackColor().CGColor
        self.view.addSubview(optionTable)
        
        //barButtonRight
        barButtonRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem = barButtonRight
        
    }
    
    //shuffleOptions
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let count = countElements(list)
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    //answerQuestion
    func done(){
        if let indexPath = self.optionTable.indexPathForSelectedRow(){
            var alert = UIAlertController(title:"", message:"Will you answer this question?", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
                answered = true
                var correctionController = self.storyboard?.instantiateViewControllerWithIdentifier("correction") as CorrectionViewController
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
    
    
    //pickerViewDelegate
    /*func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component == 0{
            return 100
        }
        else{
            return 20
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        let item = options[row]
        return item
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = options[row]
        println(item)
        
    }*/
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
        return 35
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
