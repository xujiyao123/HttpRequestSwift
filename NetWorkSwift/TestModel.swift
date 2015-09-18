//
//  TestModel.swift
//  NetWorkSwift
//
//  Created by 徐继垚 on 15/9/18.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit

class TestModel: NSObject {
    
    
    class func loadFirstData(delegate:HttpRequestLoadDataProtocol) -> Void{
        
        let info = HttpRequestInfo(url: "123", delegate: delegate)
        
    
        info.sendRequest()
        
        
    }
    
    class func loadSecondData(delegate:HttpRequestLoadDataProtocol) -> Void{
        
        let info = HttpRequestInfo(url: "234", delegate: delegate)
        
        
        info.sendRequest()
        
        
    }
    
    

}
