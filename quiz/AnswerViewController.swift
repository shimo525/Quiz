//
//  AnswerViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/15.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    //UI
    var nameLabel:UILabel!
    var contentLabel:UILabel!
    var optionPicker:UIPickerView!
    var barButtonRight:UIBarButtonItem!
    
    //originalFrame
    var originalFrame:CGRect!{
        get{
            return self.view.frame
        }
    }
    
    //parameter
    var texts:[String]!
    var orderOptions:[String]!
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
        optionPicker = UIPickerView(frame: CGRectMake((originalFrame.width - 100)/2, originalFrame.height/2, 100, originalFrame.height/10))
        optionPicker.dataSource = self
        optionPicker.delegate = self
        self.view.addSubview(optionPicker)
        
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
        var alert = UIAlertController(title:"", message:"Will you answer this question?", preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            var correctionController = self.storyboard?.instantiateViewControllerWithIdentifier("correction") as CorrectionViewController
            correctionController.myAnswer = self.options[self.optionPicker.selectedRowInComponent(0)]
            correctionController.correctAnswer = self.orderOptions[0]
            correctionController.index = self.index
            correctionController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            self.presentViewController(correctionController, animated: true, completion:nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in
        }))
        self.presentViewController(alert, animated:true ,completion:nil)
    }
    
    
    //pickerViewDelegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
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
