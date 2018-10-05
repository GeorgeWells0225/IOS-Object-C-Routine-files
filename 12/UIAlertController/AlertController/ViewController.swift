//
//  ViewController.swift
//  AlertController


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    func dismissAlert(alert: UIAlertAction!)
    {
        self.dismissViewControllerAnimated(true , completion: nil)
    }

    @IBAction func openAlertView(sender: AnyObject) {
        
        let alrtController : UIAlertController = UIAlertController(title: "Hi", message: "This is alert controller", preferredStyle:.Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: dismissAlert)
        
        alrtController.addAction(cancelAction)
        
        self.presentViewController(alrtController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func openActionSheet(sender: AnyObject) {
        
        let actionsheetController : UIAlertController = UIAlertController(title: "Hi", message: "This is alert controller", preferredStyle:.ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: dismissAlert)
        
        actionsheetController.addAction(cancelAction)
        
        self.presentViewController(actionsheetController, animated: true, completion: nil)
    }
}

