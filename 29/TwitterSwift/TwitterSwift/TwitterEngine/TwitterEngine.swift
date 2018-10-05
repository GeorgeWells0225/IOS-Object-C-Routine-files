//
//  TwitterEngine.swift
//  TwitterSwift
//
//  Created by Luong Huy Duc on 22/12/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

import UIKit
import Foundation

protocol TwitterEngineDelegate {
    func controllerToPresentAuthenticationWebView () -> UIViewController
}

enum HTTPRequestMethod : String {
    case POST = "POST"
    case GET  = "GET"
}

class TwitterEngine {
    // MARK: Public Properties
    var delegate : TwitterEngineDelegate?
    var user : TwitterConsumer?
    var authenticatedUserName : String? {
        return self.accessToken?.authenticatedScreenName
    }
    //block of code to excute when the authentication completes
    var onCompletingAuthenticationBlock: (() -> Void)?
    
    class var sharedEngine : TwitterEngine {
        struct Singleton {
            static let instance = TwitterEngine ()
        }
        return Singleton.instance
    }
    
    // MARK:  Private Properties
    private let session = NSURLSession (configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private lazy var accessToken = AccessToken.loadAccessToken()
    
    // MARK:  Public functions
    func isAuthenticated () -> Bool {
        if self.user == nil || self.accessToken?.key == nil || self.accessToken?.secret == nil {
            return false
        }
        return true
    }
    
    func requestAccessToken (requestToken : Token) {
        let url = NSURL (string: "https://api.twitter.com/oauth/access_token")
        var request = self.generateSignedRequest(url!, token: requestToken, method: .POST)
        self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) {
               self.accessToken = AccessToken (stringToParse: responseString).save()
                //run completion block on main queue
                if let completionBlock = self.onCompletingAuthenticationBlock {
                    dispatch_async(dispatch_get_main_queue(), completionBlock)
                }
            }
        }).resume()
    }
    
    func authenticate (completionHandler: (()->Void)?) {
        self.onCompletingAuthenticationBlock = completionHandler
        let url = NSURL (string: "https://api.twitter.com/oauth/request_token")
        var request = self.generateSignedRequest(url!, token: nil, method: .POST)
        self.session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error == nil {
                    if let responseString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        var token = Token (stringToParse: responseString)
                        var controller = self.delegate?.controllerToPresentAuthenticationWebView()
                        var authenticationWebController = TwitterAuthenticationWebController (requestToken: token)
                        var navCon = UINavigationController (rootViewController:authenticationWebController)
                        controller?.presentViewController(navCon, animated: true, completion: nil)
                    }
                }
                else {
                    var   alertView = UIAlertView (title: "Network Error", message: "Failed to fetch Request TOken", delegate: nil, cancelButtonTitle: "Okay", otherButtonTitles: "")
                    alertView.show()
                }
            })
        }).resume()
    }
    
    // MARK: Private functions
    private func generateSignedRequest (url : NSURL, token: Token?, method : HTTPRequestMethod)
        -> NSURLRequest {
            var mutablRequest = NSMutableURLRequest (URL: url, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
            mutablRequest.HTTPMethod = method.rawValue
            if let user = self.user  {
                self.signRequest(mutablRequest, token: token, user: user)
            }
            return mutablRequest
    }
    
    private func signRequest (request : NSMutableURLRequest, token : Token?, user: TwitterConsumer) {
        TwitterRequestSinging.signRequest(request , withToken: token?.key, tokenSecret: token?.secret, verifier: token?.verifier, key: user.key, secret: user.secret)
    }
}