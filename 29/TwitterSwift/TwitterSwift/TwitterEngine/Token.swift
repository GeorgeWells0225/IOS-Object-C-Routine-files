//
//  Token.swift
//  TwitterSwift
//
//  Created by Luong Huy Duc on 22/12/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

import Foundation
class Token : NSObject, NSCoding {
    let key = ""
    let secret = ""
    var verifier = ""
    
    required init (stringToParse : String) {
        let components = stringToParse.componentsSeparatedByString("&")
        for value in components {
            let elements = value.componentsSeparatedByString("=")
            if elements[0] == "oauth_token" {
                self.key = elements[1]
            }
            if elements[0] == "oauth_token_secret" {
                self.secret = elements[1]
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObjectForKey("key") as String
        self.secret = aDecoder.decodeObjectForKey("secret") as String
        self.verifier = aDecoder.decodeObjectForKey("verifier") as String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.key, forKey: "key")
        aCoder.encodeObject(self.secret, forKey: "secret")
        aCoder.encodeObject(self.verifier, forKey: "verifier")
    }
}

class AccessToken : Token {
    let authenticatedUID = ""
    let authenticatedScreenName = ""
    
    required init (stringToParse : String) {
        let components = stringToParse.componentsSeparatedByString("&")
        for value in components {
            let element = value.componentsSeparatedByString("=")
            if element[0] == "user_id" {
                self.authenticatedUID = element[1]
            }
            if element[0] == "screen_name" {
                self.authenticatedScreenName = element[1];
            }
        }
        super.init(stringToParse: stringToParse)
    }
    
    func save () -> AccessToken {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "tokenKey")
        return self
    }
    
    class func loadAccessToken () -> AccessToken? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("tokenKey") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? AccessToken
        }
        return nil
    }

    
    required init(coder aDecoder: NSCoder) {
        self.authenticatedUID = aDecoder.decodeObjectForKey("authenticatedUID") as String
        self.authenticatedScreenName = aDecoder.decodeObjectForKey("authenticatedScreenName") as String
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.authenticatedScreenName, forKey: "authenticatedScreenName")
        aCoder.encodeObject(self.authenticatedUID, forKey: "authenticatedUID")
        super.encodeWithCoder(aCoder)
    }
}



