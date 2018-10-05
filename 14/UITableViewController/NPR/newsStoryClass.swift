//
//  newsStoryClass.swift
//  NPR


import UIKit

class newsStoryClass: NSObject {

    var title :NSString
    var date :NSString
 
    init(title : String, date : String) {
        self.title = title
        self.date = date
    }
   
}
