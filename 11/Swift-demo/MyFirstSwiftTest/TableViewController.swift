//
//  TableViewController.swift
//  MyFirstSwiftTest
//
//  Created by julong on 14-10-15.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

import UIKit

class TableViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {

    var contactGroupArray:NSMutableArray!
    var myTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.title = "表格UITableView"
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-64), style: UITableViewStyle.Grouped)
        myTableView.backgroundColor = UIColor.clearColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        
        //表格数据源填充
        contactGroupArray = NSMutableArray()
        
        //分组1
        var contactArray1:NSMutableArray = NSMutableArray()
        
        var contact1 :KCContact = KCContact()
        contact1.initUse("王", lastName: "小二", phoneNumber:"18500131234")
        contactArray1.addObject(contact1)
        
        var contact2 :KCContact = KCContact()
        contact2.initUse("王", lastName: "三三", phoneNumber:"18500133154")
        contactArray1.addObject(contact2)
        
        var contactGroup1:KCContactGroup = KCContactGroup()
        contactGroup1.initUse("王", detail: "姓氏为王", contacts: contactArray1)
        contactGroupArray.addObject(contactGroup1)
        
        //分组2
        var contactArray2:NSMutableArray = NSMutableArray()
        
        var contact3 :KCContact = KCContact()
        contact3.initUse("薛", lastName: "小宝", phoneNumber:"18500131284")
        contactArray2.addObject(contact3)
        
        var contact4 :KCContact = KCContact()
        contact4.initUse("薛", lastName: "美秀", phoneNumber:"18500133337")
        contactArray2.addObject(contact4)
        
        var contact5 :KCContact = KCContact()
        contact5.initUse("薛", lastName: "达华", phoneNumber:"18504231237")
        contactArray2.addObject(contact5)
        
        var contactGroup2:KCContactGroup = KCContactGroup()
        contactGroup2.initUse("薛", detail: "姓氏为薛", contacts: contactArray2)
        contactGroupArray.addObject(contactGroup2)
        
        
        //分组3
        var contactArray3:NSMutableArray = NSMutableArray()
        
        var contact6 :KCContact = KCContact()
        contact6.initUse("刘", lastName: "小笑", phoneNumber:"18524131284")
        contactArray3.addObject(contact6)
        
        var contact7 :KCContact = KCContact()
        contact7.initUse("刘", lastName: "大溪", phoneNumber:"18500134337")
        contactArray3.addObject(contact7)
        
        var contact8 :KCContact = KCContact()
        contact8.initUse("刘", lastName: "立校", phoneNumber:"18504265236")
        contactArray3.addObject(contact8)
        
        var contactGroup3:KCContactGroup = KCContactGroup()
        contactGroup3.initUse("刘", detail: "姓氏为刘", contacts: contactArray3)
        contactGroupArray.addObject(contactGroup3)
        
        
    }
    
    //UITableViewDataSource
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return contactGroupArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var contactGroup = contactGroupArray.objectAtIndex(section) as KCContactGroup
        return contactGroup.contacts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var identifier = "cellIdentifier"
//        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier) as UITableViewCell
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        let contactGroup = contactGroupArray.objectAtIndex(indexPath.section) as KCContactGroup
        let contact = contactGroup.contacts.objectAtIndex(indexPath.row) as KCContact
        
//        cell.textLabel?.text =  contact.fristName! + contact.lastName! + contact.testSum() + contact.testSum("传参")
        cell.textLabel.text =  contact.fristName! + contact.lastName!
 //        cell.textLabel?.font = UIFont.systemFontOfSize(12)
        cell.detailTextLabel?.text = contact.phoneNumber
        cell.imageView.image = UIImage(named:"iOS-defaultHead0.png")
        
        return cell
    }
    
    //UITableViewDelegate
    //设置分组头标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let contactGroup = contactGroupArray.objectAtIndex(section) as KCContactGroup
        return contactGroup.name
    }
    
    //设置分区尾部内容
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let contactGroup = contactGroupArray.objectAtIndex(section) as KCContactGroup
        return contactGroup.detail
    }
    
    // 返回每组标题索引
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        var indexs:NSMutableArray = NSMutableArray()
        for var  i=0;i<contactGroupArray.count;i++
        {
            let contactGroup = contactGroupArray.objectAtIndex(i) as KCContactGroup
            indexs.addObject(contactGroup.name!)
        }
        return indexs
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
