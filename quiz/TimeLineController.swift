//
//  TableViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/11.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

class TimeLineController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations

        configure()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var headerView:UITableView!
    var barButtonRight:UIBarButtonItem!
    
    
    //parse
    func loadData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"quiz")
        query.orderByAscending("CreatedAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            callback(objects as [PFObject] ,error)
        }
    }
    
    func configure(){
        //tableView
        headerView.delegate = self
        headerView.dataSource = self
        
        //parseData
        self.loadData{ (quizes,error) -> () in
            quizArray = quizes
            println(quizArray)
            self.headerView.reloadData()
        }
        //title
        self.title = "TimeLine"
        
        //barButtonItem
        barButtonRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action:"add")
        self.navigationItem.rightBarButtonItem = barButtonRight
        
    }
    

    func add(){
        self.performSegueWithIdentifier("Create", sender: nil)
    }
    
    func answer(sender:AnyObject){
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Answer"{
            let row = sender as? Int
            if row != nil{
                var titleText:String? = quizArray[row!].objectForKey("title") as? String
                var nameText:String? = quizArray[row!].objectForKey("name") as? String
                var contentText:String? = quizArray[row!].objectForKey("content") as? String
                var options:[String] = []
                for l in 1...4{
                    var option:String? = quizArray[row!].objectForKey("choice\(l)") as? String
                    if option == nil{
                        break
                    }
                    else{
                        options.append(option!)
                    }
                }
                let answerController = segue.destinationViewController as AnswerViewController
                answerController.texts = [titleText!,nameText!,contentText!]
                answerController.options = options
            }
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TimeLineCell
        var nameText:String? = quizArray[indexPath.row].objectForKey("name") as? String
        var titleText:String? = quizArray[indexPath.row].objectForKey("title") as? String
        cell.setText(nameText!, title: titleText!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("Answer", sender: indexPath.row)
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
