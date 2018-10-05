//
//  KCContact.swift
//  MyFirstSwiftTest
//
//  Created by julong on 14-10-17.
//  Copyright (c) 2014年 renbing. All rights reserved.
//

import UIKit

class KCContact: NSObject {
   
    var fristName:String?
    var lastName:String?
    var phoneNumber:String?
    
//    //测试两个方法 传参与不传参
//    func testSum()->String{
//        return "不传参数"
//    }
//    
//    func testSum(sum: String)->String{
//        return sum
//    }
    
    func initUse(firstName:String,lastName:String,phoneNumber:String)
    {
        self.fristName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        
    }
    
}
