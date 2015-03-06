//
//  TableViewController.swift
//  quiz
//
//  Created by 下馬場光祐 on 2015/02/11.
//  Copyright (c) 2015年 Kosuke Shimobaba. All rights reserved.
//

import UIKit

var quizArray:[PFObject] = []

class TimeLineController: UIViewController,RefreshButton,UITableViewDataSource,UITableViewDelegate{

    override func viewDidLoad(){
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations

        configure()
        
        //quizData
        self.loadQuizData{ (quizes,error) -> () in
            quizArray = quizes
            println("loadedData")
            self.headerView.reloadData()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var tabBarController = self.navigationController?.viewControllers[0] as TabBarController
        tabBarController.title = "TimeLine"
        tabBarController.refreshDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var headerView:UITableView!
    var refreshButton:UIBarButtonItem!
    var hud:MBProgressHUD!

    func configure(){
        //tableView
        headerView.delegate = self
        headerView.dataSource = self
        headerView.frame = self.view.frame
        
        //title
        self.title = "TimeLine"
    }
    
    //parse
    func loadQuizData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"quiz")
        query.orderByDescending("CreatedAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            callback(objects as [PFObject] ,error)
        }
    }
    
    func refresh(){
        progressHud()
        self.loadQuizData{ (quizes,error) -> () in
            quizArray = quizes
            println("loadedData")
            self.hud.hide(true, afterDelay: 0.3)
            self.headerView.reloadData()
        }
    }
    
    func progressHud(){
        //MBProgressHUD
        self.hud = MBProgressHUD(view: self.view)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDModeIndeterminate
        hud.labelText = "Loading"
        self.view.addSubview(hud)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Answer"{
            let row = sender as? Int
            if row != nil{
                var titleText:String? = quizArray[row!].objectForKey("title") as? String
                var nameText:String? = quizArray[row!].objectForKey("name") as? String
                var contentText:String? = quizArray[row!].objectForKey("content") as? String
                var options:[String] = []
                for l in 0...3{
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
                answerController.orderOptions = options
                answerController.index = row
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
        var number:Int? = quizArray[indexPath.row].objectForKey("correction") as? Int
        cell.setText(nameText!, title: titleText! ,num: number!)
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
