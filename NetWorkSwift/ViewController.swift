//
//  ViewController.swift
//  NetWorkSwift
//
//  Created by 徐继垚 on 15/9/17.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,HttpRequestLoadDataProtocol {

  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
//        
//        let info = HttpRequestInfo(url: "http://api.liwushuo.com/v2/banners?channel=iOS", delegate: self, state: XUDataRequestState.post)
//        info.httpBody =
//    
//
//        let helper = HttpRequestHelper.sharedHelper()
//
//        helper.sandAsyncHttpRequest(info)
        

   
        
        
          let info = HttpRequestInfo(url: "http://api.liwushuo.com/v2/banners?channel=iOS", delegate: self)
        
          info.sendRequest()
      
    }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

