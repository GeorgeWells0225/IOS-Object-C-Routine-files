//
//  TwitterAuthenticationWebController.swift
//  TwitterSwift
//
//  Created by Luong Huy Duc on 22/12/14.
//  Copyright (c) 2014 2359Media. All rights reserved.
//

import Foundation
import UIKit

class TwitterAuthenticationWebController : UIViewController, UIWebViewDelegate {
    var webView : UIWebView?
    var requestToken : Token?
    let newPinJS = "var d = document.getElementById('oauth-pin'); if (d == null) d = document.getElementById('oauth_pin'); if (d) { var d2 = d.getElementsByTagName('code'); if (d2.length > 0) d2[0].innerHTML; }"
    
    let oldPinJS = "var d = document.getElementById('oauth-pin'); if (d == null) d = document.getElementById('oauth_pin'); if (d) d = d.innerHTML; d;"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (requestToken : Token) {
        super.init(nibName: nil, bundle: nil)
        let screenRect = UIScreen.mainScreen().bounds
        self.webView = UIWebView (frame: screenRect)
        self.webView?.delegate = self
        self.requestToken = requestToken
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView!);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismiss")
        if let oauth_token = self.requestToken?.key {
            var urlString = "https://api.twitter.com/oauth/authorize?oauth_token=\(oauth_token)"
            var request = NSMutableURLRequest (URL: NSURL(string: urlString)!)
            self.webView?.loadRequest(request)
        }
    }
    
    func dismiss () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var pin : String? = webView.stringByEvaluatingJavaScriptFromString(self.newPinJS)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if pin?.utf16Count < 7 {
            pin = webView.stringByEvaluatingJavaScriptFromString(self.oldPinJS)?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        if pin?.utf16Count > 0 {
            self.requestToken?.verifier = pin!
            TwitterEngine.sharedEngine.requestAccessToken(self.requestToken!)
            self.dismiss()
        }
    }
}