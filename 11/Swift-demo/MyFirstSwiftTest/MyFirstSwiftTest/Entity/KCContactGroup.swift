//
//  KCContactGroup.swift
//  MyFirstSwiftTest
//
//  Created by julong on 14-10-17.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

import UIKit

class KCContactGroup: NSObject {
   
    var name:String?
    var detail:String?
    var contacts:NSMutableArray = NSMutableArray()
    
    
    func initUse(name:String,detail:String,contacts:NSMutableArray)
    {
        self.name = name
        self.detail = detail
        self.contacts = contacts
    }
    
}
