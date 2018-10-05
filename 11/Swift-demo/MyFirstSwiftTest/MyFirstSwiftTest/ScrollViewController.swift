//
//  ScrollViewController.swift


import UIKit


class ScrollViewController: UIViewController,UIScrollViewDelegate {

    var slideArray:NSArray!
    var pageControl :UIPageControl!
    var labelScrollView:UIScrollView!
 
    var mainScreenWidthUse:CGFloat = 0
    var mainScreenHeightUse:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "滚动页面UIScrollView"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        slideArray = ["1","2","3","4","5"]
        
        let mainScreenWidth = self.view.frame.size.width
        mainScreenWidthUse = mainScreenWidth
        let mainScreenHeight = self.view.frame.size.height
        mainScreenHeightUse = mainScreenHeight
        
        //UIScrollView
        labelScrollView  = UIScrollView()
        labelScrollView.frame = self.view.frame
        labelScrollView.bounces = false
        labelScrollView.backgroundColor = UIColor.clearColor()
        labelScrollView.pagingEnabled = true
        //决定ScrollView第一页显示的内容
        labelScrollView.contentOffset = CGPoint(x: mainScreenWidthUse, y: 0)
        labelScrollView.contentSize = CGSize(width :(CGFloat)(slideArray.count+2) * mainScreenWidth, height :mainScreenHeight-100)
        labelScrollView.showsHorizontalScrollIndicator = false
        labelScrollView.showsVerticalScrollIndicator = false
        labelScrollView.delegate = self
        self.view.addSubview(labelScrollView)
        
        //为了实现循环滚动
        //最后一页
        var startLabel:UILabel! = UILabel(frame: CGRect(x: 0, y: 0, width: mainScreenWidth, height: mainScreenHeight))
        startLabel.backgroundColor = UIColor.clearColor()
        startLabel.textColor = UIColor.blackColor()
        startLabel.textAlignment = NSTextAlignment.Center
        startLabel.font = UIFont.boldSystemFontOfSize(32)
        startLabel.text = "第\(slideArray.objectAtIndex(slideArray.count-1))页"
        labelScrollView.addSubview(startLabel)
        
        for var i=0;i<slideArray.count;i++
        {
            var useLabel:UILabel! = UILabel(frame: CGRect(x: (CGFloat)(i + 1)*mainScreenWidth, y: 0, width: mainScreenWidth, height: mainScreenHeight))
            useLabel.backgroundColor = UIColor.clearColor()
            useLabel.textColor = UIColor.blackColor()
            useLabel.textAlignment = NSTextAlignment.Center
            useLabel.font = UIFont.boldSystemFontOfSize(32)
            useLabel.text = "第\(slideArray.objectAtIndex(i))页"
            labelScrollView.addSubview(useLabel)
        }
        
        //第一页
        var endLabel:UILabel! = UILabel(frame: CGRect(x: (CGFloat)(slideArray.count + 1)*mainScreenWidth, y: 0, width: mainScreenWidth, height: mainScreenHeight))
        endLabel.backgroundColor = UIColor.clearColor()
        endLabel.textColor = UIColor.blackColor()
        endLabel.textAlignment = NSTextAlignment.Center
        endLabel.font = UIFont.boldSystemFontOfSize(32)
        endLabel.text = "第\(slideArray.objectAtIndex(0))页"
        labelScrollView.addSubview(endLabel)
        
        //UIPageControl
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: mainScreenHeight-100, width: mainScreenWidth, height: 20)
        pageControl.pageIndicatorTintColor = UIColor.redColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.numberOfPages = slideArray.count
        pageControl.addTarget(self, action: Selector("pageControlAction"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(pageControl)
        
    }
  
    //点击pagecontrol响应事件
    func pageControlAction(){
        var page:Int = pageControl.currentPage
        labelScrollView.setContentOffset(CGPoint(x: mainScreenWidthUse*(CGFloat)(page+1), y: 0), animated: true)
    }
    
    //UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        //当前页
        var currentPage = Int(labelScrollView.contentOffset.x/mainScreenWidthUse)
        
//        var currentPage = Int((labelScrollView.contentOffset.x - mainScreenWidthUse / ( CGFloat(slideArray.count) + 2)) / mainScreenWidthUse + 1)
        
        if (currentPage == 0)
        {
            labelScrollView.scrollRectToVisible(CGRect(x: mainScreenWidthUse * CGFloat(slideArray.count), y: 0, width: mainScreenWidthUse, height: mainScreenHeightUse), animated: false)
        }
        else if (currentPage == slideArray.count + 1)
        {
            labelScrollView.scrollRectToVisible(CGRect(x: mainScreenWidthUse, y: 0, width: mainScreenWidthUse, height: mainScreenHeightUse), animated: false)
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page:Int = Int(labelScrollView.contentOffset.x/mainScreenWidthUse)-1
        pageControl.currentPage = page;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
