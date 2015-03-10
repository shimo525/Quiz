//
//  MyPageController.swift
//  
//
//  Created by 下馬場光祐 on 2015/02/19.
//
//

import UIKit

var myQuizArray:[PFObject] = []

class MyPageController: UIViewController,RefreshButton,UITableViewDelegate,UITableViewDataSource{

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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var tabBarController = self.navigationController?.viewControllers[0] as TabBarController
        tabBarController.title = "MyPage"
        tabBarController.refreshDelegate = self
    }
    
    
    func refreshCon(){
        refresh()
        refreshControl.endRefreshing()
    }
    
    func refreshBut(){
        progressHud()
        refresh()
    }
    
    func refresh(){
        self.loadMyQuizData{ (quizes,error) -> () in
            myQuizArray = quizes
            println("loadedMyData")
            self.hud.hide(true, afterDelay: 0.3)
            self.myHeaderView.reloadData()
        }
    }
    
    func progressHud(){
        //MBProgressHUD
        self.hud = MBProgressHUD(view: self.view)
        hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = "Loading"
        self.view.addSubview(hud)
    }
    
    
    @IBOutlet var myHeaderView:UITableView!
    var barButtonLeft:UIBarButtonItem!
    var hud:MBProgressHUD!
    var refreshControl:UIRefreshControl!
    
    func configure(){
        myHeaderView.delegate = self
        myHeaderView.dataSource = self
        myHeaderView.frame = self.view.frame
        
        //refreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshCon", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.frame = CGRectMake(0, 0, 0, 0)
        myHeaderView.addSubview(refreshControl)
    }
    
    func loadMyQuizData(callback:([PFObject]!,NSError!) -> ()){
        var query:PFQuery = PFQuery(className:"quiz")
        query.whereKey("name", equalTo:PFUser.currentUser().username)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{(objects:[AnyObject]!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            callback(objects as [PFObject] ,error)
        }
    }
    
    func DeleteMyQuizData(objectID:String/* ,callback:(PFObject!,NSError!) -> ()*/){
        var query:PFQuery = PFQuery(className:"quiz")
        query.whereKey("name", equalTo:PFUser.currentUser().username)
        query.whereKey("objectID", equalTo:objectID)
        query.getObjectInBackgroundWithId(objectID, block:{(object:PFObject!,error:NSError!) -> Void in
            if error != nil{//エラー処理
                println("error")
            }
            object.delete()
//            callback(object as PFObject ,error)
        }
)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myQuizArray.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TimeLineCell
        let titleText = myQuizArray[indexPath.row].objectForKey("title") as? String
        var number:Int? = myQuizArray[indexPath.row].objectForKey("correction") as? Int
        cell.setText(PFUser.currentUser().username, title: titleText!,num: number!)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var alert = UIAlertController(title: "", message: "Delete this question?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in
            var id = myQuizArray[indexPath.row].objectId
            println(id)
            myQuizArray.removeAtIndex(indexPath.row)
            self.myHeaderView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.DeleteMyQuizData(id)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {action in}))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    /*// Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */
    

    
    // Override to support editing the table view.
    /*func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/
    

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
