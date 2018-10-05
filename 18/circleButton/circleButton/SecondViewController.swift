//
//  SecondViewController.swift


import UIKit

class SecondViewController: UIViewController,UITabBarDelegate {
//@property(strong,nonatomic) UIViewController *vc
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var fiv:UIViewController!
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    
    let textLabel = UILabel(frame:CGRectMake(110, 250, 200, 100))
    
    func swipeRight(){
        //self.tabBarController?.presentViewController(fiv, animated: true, completion: {})
        //self.tabBarController?.tabBar.hidden = false
        //self.presentViewController(fiv, animated: true, completion: {})
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func swippedView(sender:UIGestureRecognizer){
        self.tabBarController?.tabBar.hidden = true
    }
    
    func swippedDown(){
        //self.tabBarController?.tabBar.hidden = false
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        println(item)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.hidden = true
        
        
        textLabel.backgroundColor = UIColor.blueColor()
        
        textLabel.alpha = 0.9
        textLabel.textColor = UIColor.yellowColor()
        textLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(textLabel)
        //self.tabBarController?.tabBar.delegate = self
        fiv = storyBoard.instantiateViewControllerWithIdentifier("first") as UIViewController
                
        swipeUpRec.direction = UISwipeGestureRecognizerDirection.Up
        swipeDownRec.direction = UISwipeGestureRecognizerDirection.Down
        swipeLeftRec.direction = UISwipeGestureRecognizerDirection.Left
        swipeRightRec.direction = UISwipeGestureRecognizerDirection.Right

        swipeRightRec.addTarget(self, action: "swipeRight")
        swipeUpRec.addTarget(self,action:"swippedView:")
        swipeDownRec.addTarget(self,action:"swippedDown")
        swipeLeftRec.addTarget(self,action:"swippedView:")
        
        self.view.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeUpRec)
        self.view.addGestureRecognizer(swipeDownRec)
        self.view.alpha = 0.95

        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        //println(self.view.bounds)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

