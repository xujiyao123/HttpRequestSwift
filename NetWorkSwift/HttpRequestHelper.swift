//
//  HttpRequestHelper.swift
//  NetWorkSwift
//
//  Created by 徐继垚 on 15/9/17.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit



    
var onceToken : dispatch_once_t = 0
    
var helper : HttpRequestHelper? = nil

class HttpRequestHelper: NSObject {
    
    var session : NSURLSession?
    
    class func sharedHelper() -> HttpRequestHelper {
            
            
            dispatch_once(&onceToken) {
                helper = HttpRequestHelper()
            }
            return helper!
    }
    

    
    func sandAsyncHttpRequest(info : HttpRequestInfo? ) -> Void {
        
        
        let urlStr = NSURL(string: (info?.urlStr)!)
        
        
        session  = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        

        if info?.state == XUDataRequestState.get {
        
        let request = NSMutableURLRequest(URL:urlStr!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        request.HTTPMethod = "GET"
        
 
        let task  =  session!.dataTaskWithRequest(request) { (result:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            
          
            
            if result != nil && error == nil {
                
                let jsonResult = try? NSJSONSerialization.JSONObjectWithData(result!, options: NSJSONReadingOptions.MutableContainers)
                
                info?.delegate?.requestSuccess(jsonResult!, operation:response as! NSHTTPURLResponse)
                
                
            }else {
                
                info?.delegate?.requestFailed(error)
                
                
            }
            }
            task.resume()
        }
        else if info?.state == XUDataRequestState.post {
            
            let request = NSMutableURLRequest(URL: urlStr!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
            request.HTTPMethod = "POST"
            request.HTTPBody = info?.httpBody
            
            let task : NSURLSessionDataTask = session!.dataTaskWithRequest(request, completionHandler: { (result:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                
                if result != nil && error == nil {
                    
                    let jsonResult = try?NSJSONSerialization.JSONObjectWithData(result!, options: NSJSONReadingOptions.MutableContainers)
                    info?.delegate?.requestSuccess(jsonResult!, operation: response as! NSHTTPURLResponse)
                    
                }else {
                    
                    
                    info?.delegate?.requestFailed(error)
                    
                    
                }
            })
            task.resume()
            
        }
        
    }
    
    func cancelRequest() -> Void {
        
        
        session?.finishTasksAndInvalidate()
        
        
    }
    
    
    
    
    
    

}
