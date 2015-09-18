# HttpRequestSwift
基于NSURLSession 封装的网络请求 使用简单 支持多种请求方式



我建议网络层是以Delegate为主，Notification为辅。原因如下：

尽可能减少跨层数据交流的可能，限制耦合
统一回调方法，便于调试和维护
在跟业务层对接的部分只采用一种对接手段（在我这儿就是只采用delegate这一个手段）限制灵活性，以此来交换应用的可维护性

然后我们顺便来说说为什么尽量不要用block。
block很难追踪，难以维护
我们在调试的时候经常会单步追踪到某一个地方之后，发现尼玛这里有个block，如果想知道这个block里面都做了些什么事情，这时候就比较蛋疼了。
block会延长相关对象的生命周期
block会给内部所有的对象引用计数加一，这一方面会带来潜在的retain cycle，不过我们可以通过Weak Self的手段解决。另一方面比较重要就是，它会延长对象的生命周期。

在网络回调中使用block，是block导致对象生命周期被延长的其中一个场合，当ViewController从window中卸下时，如果尚有请求带着block在外面飞，然后block里面引用了ViewController（这种场合非常常见），那么ViewController是不能被及时回收的，即便你已经取消了请求，那也还是必须得等到请求着陆之后才能被回收。

然而使用delegate就不会有这样的问题，delegate是弱引用，哪怕请求仍然在外面飞，，ViewController还是能够及时被回收的，回收之后指针自动被置为了nil，无伤大雅。

所以平时尽量不要滥用block，尤其是在网络层这里。




引用iOS架构师的话,基于NSURLSesson封装了一套Delegate回调的请求方法,目前只支持GET,POST,持续更新中.



基本使用方法


          let info = HttpRequestInfo(url: "http://www.baidu.com", delegate: self)
        
          info.sendRequest()

或者你也可以这样

        let info = HttpRequestInfo(url: "http://www.baidu,com", delegate: self, state: XUDataRequestState.post)
        info.httpBody = body
    

        let helper = HttpRequestHelper.sharedHelper()

        helper.sandAsyncHttpRequest(info)
        
        
消息会从代理回调

     func requestSuccess(data: AnyObject, operation: NSHTTPURLResponse) {
        
       let datastr = try? NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted)
        let jsonstr: String = NSString(data: datastr!, encoding: NSUTF8StringEncoding) as! String
        let popTime = dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
          let alert =  UIAlertController(title: "请求成功", message: jsonstr, preferredStyle: UIAlertControllerStyle.Alert)
          self.presentViewController(alert, animated: true, completion: nil)
        }
        print(operation.statusCode)
        
    }
    func requestFailed(error: NSError?) {
        print(error)
    }

可以从Model模型中拿取数据方便管理

    class func loadFirstData(delegate:HttpRequestLoadDataProtocol) -> Void{
        
        let info = HttpRequestInfo(url: "123", delegate: delegate)
        
    
        info.sendRequest()
        
        
    }
    
    class func loadSecondData(delegate:HttpRequestLoadDataProtocol) -> Void{
        
        let info = HttpRequestInfo(url: "234", delegate: delegate)
        
        
        info.sendRequest()
        
        
    }

调用方法

      TestModel.loadFirstData(self)
      TestModel.loadSecondData(self)








