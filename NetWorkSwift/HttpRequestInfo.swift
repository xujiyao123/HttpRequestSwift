//
//  HttpRequestInfo.swift
//  NetWorkSwift
//
//  Created by 徐继垚 on 15/9/17.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit

enum XUDataRequestState {
    
    case get
    case post
    
}
protocol HttpRequestLoadDataProtocol :NSObjectProtocol {
    
    
    
    func requestSuccess(data:AnyObject , operation:NSHTTPURLResponse)
    
    func requestFailed(error :NSError?)
    
    
}

class HttpRequestInfo: NSObject {

    var urlStr : String?
    
    var httpBody : NSData?
    
    var delegate : HttpRequestLoadDataProtocol?

    var state : XUDataRequestState?
    
    
    
    
    init(url: String , delegate:HttpRequestLoadDataProtocol ) {
        
         self.urlStr = url
        
        self.delegate = delegate
        
        self.state = XUDataRequestState.get
        
       
        
    }
    init(url: String , delegate:HttpRequestLoadDataProtocol , state: XUDataRequestState) {
        
        self.urlStr = url
        self.delegate = delegate
        self.state = state
            
    }
    
    func sendRequest() {
        
        let helper = HttpRequestHelper.sharedHelper()
        
        helper.sandAsyncHttpRequest(self)
    }
    
    
    
    
    
    
    
}
