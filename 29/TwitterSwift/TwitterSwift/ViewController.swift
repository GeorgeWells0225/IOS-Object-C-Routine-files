//
//  ViewController.swift
//  TwitterSwift
//
//  Created by Luong Huy Duc on 22/12/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, TwitterEngineDelegate {

    lazy var theEngine = TwitterEngine.sharedEngine
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        theEngine.delegate = self
        theEngine.user = TwitterConsumer (key: "1ReC0vmXGc0HLyeHY7XijrT9k", secret: "iIonO9o2AZWrB6PPGdOKxhQxcrxvGCLFTykLOmBsTR2FyfFg2N")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }
    
    func tweet() {
        if self.theEngine.isAuthenticated() {

        }
        else {
    
        }
    }
    
    func login() {
       self.theEngine.authenticate {
            self.refresh()
        }
    }
    
    func refresh() {
        var selector = self.theEngine.isAuthenticated() ? Selector("tweet") : Selector("login")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: selector)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: nil)
        self.title = self.theEngine.authenticatedUserName
        self.tableView.reloadData()
    }
    func controllerToPresentAuthenticationWebView() -> UIViewController {
        return self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "Indexpath \(indexPath.row)"
        return cell
    }
}

