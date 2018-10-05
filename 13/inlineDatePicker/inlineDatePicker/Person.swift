//
//  Person.swift
//  inlineDatePicker
//
//  Created by McGill, Geoff on 12/19/14.
//  Copyright (c) 2014 McGill, Geoff. All rights reserved.
//

import Foundation

class Person {
    var name: String
    var date: NSDate
    
    init(name: String, date: NSDate) {
        self.name = name
        self.date = date
    }
}