//
//  FirstViewController.swift
//  circleButton


import UIKit

protocol UIViewPassValueDelegate{
    func passValue(value:NSString)
}


class FirstViewController: UIViewController,CFShareCircleViewDelegate,UIViewPassValueDelegate{
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var sec:SecondViewController!
    
    var shareCircleView:CFShareCircleView!
    var panView: UIView!
    var circleViewShow = false
    var holderView: UIView!

    //@IBOutlet weak var text: UILabel!
    var textLabel:UILabel!
    let tapRec = UITapGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    
    //414,736
    var panviewPosition:CGPoint = CGPointMake(314,636)
    //var panviewPosition:CGPoint = CGPointMake(100,100)
    
    func passValue(value: NSString) {

    }
    
    func tappedView(sender:UIGestureRecognizer){
        print(self.view.frame.size)
        panView.alpha = 1.0
        holderView.bringSubviewToFront(panView)
        
        shareCircleView.show()
        //self.view.bringSubviewToFront(shareCircleView)
    }
    
    func swippedView(sender:UIGestureRecognizer){
        panView.alpha = 0.3
        //println(panView.center)
        panView.center = panviewPosition
    }
    
    func swipLeft(){
        //self.tabBarController?.presentViewController(sec, animated: true, completion: {})
        let value:NSString = textLabel.text!
        
        sec.textLabel.text = textLabel.text
        sec.textLabel.font = UIFont.systemFontOfSize(40)
        self.presentViewController(sec, animated: true, completion: {})
        //UIViewPassValueDelegate.passValue(value)
    }
    
    func draggedView(sender:UIGestureRecognizer){
        panView.alpha = 1.0
        
        var translation = panRec.translationInView(self.view)
        
        //monitor the position of the circle view ,not to go out of the screen
        if panView.center.x > self.view.frame.width - 25 {
            panView.center.x = self.view.frame.width - 25
        }
        if panView.center.x < 25{
            panView.center.x = 25
        }
        if panView.center.y > self.view.frame.height - 25 {
            panView.center.y = self.view.frame.height - 25
        }
        if panView.center.y < 45{
            panView.center.y = 45
        }
        
        panView.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        panRec.setTranslation(CGPointZero, inView: self.view)
        self.panviewPosition = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
    }

    @IBAction func touch(sender: AnyObject) {
        
    }
    
    //what button in circleButtonView should do in this func
    func shareCircleView(aShareCircleView: CFShareCircleView!, didSelectSharer sharer: CFSharer!) {
        //println("selected : \(sharer.name)")
        
            textLabel.text = sharer.name
            panView.center = panviewPosition
        
        //holderView.bringSubviewToFront(panView)
            //self.view.bringSubviewToFront(holderView)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        sec = SecondViewController()
        
        textLabel = UILabel(frame: CGRectMake(self.view.frame.width/2-75, self.view.frame.height/2, 150, 50))
        textLabel.backgroundColor = UIColor.yellowColor()
        textLabel.alpha = 0.6
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = ""
        
        self.view.addSubview(textLabel)
        
        panView = UIView(frame: CGRectMake(364,636,50,50))
        panView.backgroundColor = UIColor.greenColor()
        panView.layer.cornerRadius = 25
        panView.alpha = 0.5
        panView.center = panviewPosition
        panView.userInteractionEnabled = true
        panView.addGestureRecognizer(panRec)
        panView.addGestureRecognizer(tapRec)
        
        swipeUpRec.direction = UISwipeGestureRecognizerDirection.Up
        swipeDownRec.direction = UISwipeGestureRecognizerDirection.Down
        swipeLeftRec.direction = UISwipeGestureRecognizerDirection.Left
        swipeRightRec.direction = UISwipeGestureRecognizerDirection.Right

        panRec.addTarget(self,action:"draggedView:")
        tapRec.addTarget(self,action:"tappedView:")
        swipeUpRec.addTarget(self,action:"swippedView:")
        swipeDownRec.addTarget(self,action:"swippedView:")
        swipeRightRec.addTarget(self,action:"swippedView:")
        swipeLeftRec.addTarget(self,action:"swipLeft")

        
        
        holderView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        holderView.opaque = false
        holderView.addGestureRecognizer(swipeUpRec)
        holderView.addGestureRecognizer(swipeDownRec)
        holderView.addGestureRecognizer(swipeLeftRec)
        holderView.addGestureRecognizer(swipeRightRec)

        
        //panView.userInteractionEnabled = true
        self.view.addSubview(holderView)
        holderView.addSubview(panView)
        holderView.bringSubviewToFront(panView)
        
        //if panviewPosition == nil{
          //  panviewPosition = panView.center
        //}
        
        self.view.userInteractionEnabled = true
        self.view.backgroundColor = UIColor.whiteColor()
        
        if panView.center.x > self.view.frame.width/2{
            shareCircleView = CFShareCircleView(frame: self.view.frame ,location:CGPoint(x: 80, y: 200))
            shareCircleView.delegate = self
            self.view.addSubview(shareCircleView)
        }else{
            shareCircleView = CFShareCircleView(frame: self.view.frame ,location:CGPoint(x: -80, y: 200))
            shareCircleView.delegate = self
            self.view.addSubview(shareCircleView)
        }
        //println("\(panView.center)")
    }
    
    override func loadView() {
        
        super.loadView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

