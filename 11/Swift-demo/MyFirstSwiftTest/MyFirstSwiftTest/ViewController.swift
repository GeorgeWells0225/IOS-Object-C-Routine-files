//
//  ViewController.swift


import UIKit

class ViewController: UIViewController,UITextFieldDelegate
{
    var a:Int = 0
    var isuse:Bool = false
    var authButton :UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.title = "首页"
        
        // UIButton
        authButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        authButton.frame = CGRect(x: 10, y: 70, width: 150, height: 30)
        authButton.setTitle("这是一个全局按钮", forState: UIControlState.Normal)
        authButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        authButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        authButton.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        authButton.tag = 1000;
        self.view.addSubview(authButton)
        
        var btn2:UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        btn2.frame = CGRectMake(10, 100, 105, 30)
        btn2.setTitle("局部按钮", forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        btn2.tag = 1001;
        btn2.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn2)
        
        
        //UILabel
        var firstLabel:UILabel! = UILabel(frame: CGRect(x: 10, y: 130, width: 105, height: 20))
        firstLabel.backgroundColor = UIColor.clearColor()
        firstLabel.textColor = UIColor(red: 0, green: 174, blue: 232, alpha: 1)
        firstLabel.textAlignment = NSTextAlignment.Left
        firstLabel.font = UIFont.boldSystemFontOfSize(16)
        firstLabel.text = "这是一个Label"
        self.view.addSubview(firstLabel)
        
        var secondLabel = UILabel()
        secondLabel.frame = CGRectMake(10, 150, 105, 20)
        secondLabel.backgroundColor = UIColor.clearColor()
        secondLabel.textColor = UIColor(red: 100, green: 174, blue: 232, alpha: 1)
        secondLabel.textAlignment = NSTextAlignment.Center
        secondLabel.font = UIFont.systemFontOfSize(12)
        secondLabel.text = "这是第二个Label"
        secondLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        secondLabel.sizeToFit()
        self.view.addSubview(secondLabel)
        
        
        //UITextField
        var firstTextField = UITextField()
        firstTextField.backgroundColor = UIColor.whiteColor()
        firstTextField.frame = CGRectMake(10, 170, 150, 20)
        firstTextField.textColor = UIColor.blackColor()
        firstTextField.autocapitalizationType = UITextAutocapitalizationType.None //首字母自动大写
        firstTextField.autocorrectionType = UITextAutocorrectionType.No//自动纠错
        firstTextField.borderStyle = UITextBorderStyle.RoundedRect //边框样式
        firstTextField.placeholder = "请输入内容"
        firstTextField.font = UIFont(name: "Arial", size: 12.0)//字体
        firstTextField.clearButtonMode = UITextFieldViewMode.Always;//输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        firstTextField.secureTextEntry = false  //每输入一个字符就变成点 用语密码输入
        firstTextField.clearsOnBeginEditing = true //再次编辑就清空
        firstTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center //内容的垂直对齐方式
        firstTextField.adjustsFontSizeToFitWidth = false //设置为true时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
        firstTextField.keyboardType = UIKeyboardType.Default//设置键盘样式
        firstTextField.returnKeyType = UIReturnKeyType.Done //return键变成什么键
        firstTextField.keyboardAppearance=UIKeyboardAppearance.Default//键盘外观
        firstTextField.delegate = self
        self.view.addSubview(firstTextField)
        
        
        var titleArray :NSArray = ["UITableView","UIScrollView","UIWebView"]
        
        for var index=0; index<titleArray.count; index++
        {
            var btn3:UIButton! = UIButton.buttonWithType(UIButtonType.System) as? UIButton
            btn3.frame = CGRect(x: 10, y:190+index*30, width:150, height:30)
            var btnStr = "点击进入\(titleArray.objectAtIndex(index))"
            btn3.setTitle(btnStr, forState: UIControlState.Normal)
            btn3.titleLabel?.font = UIFont.systemFontOfSize(14)
            btn3.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            btn3.tag = 1002+index;
            btn3.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(btn3)
        }
        
    }
    
    //按钮点击方法
    func btnClick(sender:UIButton!)
    {
        var btn:UIButton = sender
        switch(btn.tag){
        case 1000:
            a++
            if(a>100)
            {
                a=1
            }
            println("按钮被点击了\(a)次")
            authButton.setTitle("全局按钮被点击了\(a)次", forState: UIControlState.Normal)
        case 1001:
            println("局部按钮被点击了")
        case 1002:
            println("点击进入UITableView")
            var tableVC:TableViewController = TableViewController()
            self.navigationController?.pushViewController(tableVC, animated: true)
        case 1003:
            println("点击进入UIScrollView")
            var scrollVC:ScrollViewController = ScrollViewController()
            self.navigationController?.pushViewController(scrollVC, animated: true)
        case 1004:
            println("点击进入UIWebView")
            var webVC:WebViewController = WebViewController()
            self.navigationController?.pushViewController(webVC, animated: true)
        default:
            println("无操作")
        }
    }
    
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

