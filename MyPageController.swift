//
//  MyPageController.swift
//  
//
//  Created by 下馬場光祐 on 2015/02/19.
//
//

import UIKit

var myQuizArray:[PFObject] = []

class MyPageController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        configure()
        
        self.loadMyQuizData{ (quizes,error) -> () in
            myQuizArray = quizes
            println("\(myQuizArray)")
            self.myHeaderView.reloadData()
        }
    }
    
    @IBOutlet var myHeaderView:UITableView!
    var barButtonLeft:UIBarButtonItem!
    
    func configure(){
        barButtonLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh")
        self.navigationItem.leftBarButtonItem = barButtonLeft
    }
    
    func refresh(){
    }
    
    func loadMyQuizData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"quiz")
        query.whereKey("name", equalTo:PFUser.currentUser().username)
        query.orderByAscending("CreatedAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            callback(objects as [PFObject] ,error)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as TimeLineCell
        let titleText = myQuizArray[indexPath.row].objectForKey("title") as? String
        var number:Int? = quizArray[indexPath.row].objectForKey("correction") as? Int
        cell.setText(PFUser.currentUser().username, title: titleText!,num: number!)
        
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
