# HttpRequestSwift
基于NSURLSession 封装的网络请求 使用简单 支持多种请求方式


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
