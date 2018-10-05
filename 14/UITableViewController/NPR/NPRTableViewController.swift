//
//  NPRTableViewController.swift


import UIKit


// #warning Incomplete method implementation.
let APikey = "YOur_KEY_GOES_HERE"

class NPRTableViewController: UITableViewController {
    
    //Create a NSURL Session
    var session  = NSURLSession.sharedSession()
    var nprStories = [newsStoryClass]()
    //var nprStories = NSMutableArray.alloc()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.dataTaskForNPR()
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadData:", name:"dataTaskFinished", object: nil)


        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        
        
        return self.nprStories.count
    }
    
    func dataTaskForNPR()
    {
        //replace our string url
        let urlPath: String = "http://api.npr.org/query?id=1090&output=JSON&apiKey=MDE3MjgyNjkxMDE0MTQ5NTUyODNjMzlmZA001"
        var url: NSURL = NSURL(string: urlPath)!
        var urlRequest : NSURLRequest = NSURLRequest (URL: url)
        
        
        self.session.dataTaskWithRequest(urlRequest,
            completionHandler: {(data: NSData!,
                response: NSURLResponse!,
                error: NSError!) in
                
                
                if((error) != nil)
                {
                    println(error)
                    
                }
                
                if(error==nil)
                {

                    var jsonResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    
                    //array to hold stories temp in the loop below
                    var tempHoldingForStories = [newsStoryClass]()
                    
                    var list:AnyObject! = jsonResult.valueForKey("list")!
                    
                    var story:AnyObject! = list.valueForKey("story")!
                    
                    if let storiesArray = story as? NSArray{
                        

                        //here is where i would loop and build the nprStories array for my datasource
                        for var counter = 0;counter<storiesArray.count;counter++
                        {
                        
                            
                            //create a custom class object
                            var article = newsStoryClass(title: "", date: "")
                            
                            var storyDictionary:AnyObject! = storiesArray[counter]
                            
                           // println(storyDictionary)
                            
                            // the title is inside a dictinary
                            if let storyTitleDictionary: AnyObject = storyDictionary.valueForKey("title")
                            {
                                // now we still have a dictionary lets get the title
                                var title:AnyObject! = storyTitleDictionary.valueForKey("$text")
                                if let finalTitle = title as? NSString
                                {
                                    article.title = finalTitle
                                    println(article.title)
                           
                                }
                                
                                
                            }
                            
                            // the date is inside a dictionary
                            if let storyDateDictionary: AnyObject = storyDictionary.valueForKey("pubDate")
                            {
                                var pubDate:AnyObject! = storyDateDictionary.valueForKey("$text")
                                if let finalpubDate = pubDate as? NSString
                                {
                                    article.date = finalpubDate
                                    //println(article.date)
                                }
                            }
                            
                            //add it to our array then we will reload our table
                            tempHoldingForStories.insert(article, atIndex: 0)
                            
                        }
                        
                    }
                    
                    // just adding our objects from the datatask to our main array for the tableview
                    // datasource.  use this so you are not mutating your datasource array while it is 
                    // loading the tableview on launch
                    
                    self.nprStories = tempHoldingForStories
                    
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("dataTaskFinished", object: nil)
                }
         
                // sadly this entire mess of parsing looks better in objective c
              
        }).resume()
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newsCell", forIndexPath: indexPath) as UITableViewCell

        // here is where the custom class comes in handy
        
        //This is a custom object from the datasource array
        var story = self.nprStories[indexPath.row] as (newsStoryClass)
        //see how easy this is with a custom class
        
        cell.textLabel.text = story.title;
        cell.detailTextLabel?.text = story.date
        

        return cell
    }
    
    //will be called from notification center
    func reloadData(notification: NSNotification)
    {
        // This calls a refresh on the main thread
        dispatch_async(dispatch_get_main_queue()) {
            //self.tableView.reloadData()
            
           
            self.tableView.reloadData()
        }
        
    }
}

