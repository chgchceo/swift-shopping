//
//  HomeModel.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit
import HandyJSON

class HomeModel: HandyJSON {

    var status:Int? = 0
    var message:String? = ""
    var data:DataModel?
    
    required init() {
        
    }
}

class DataModel:HandyJSON{
    
    var pageData:PageDataModel?
    
    
    required init() {
        
        
    }
}


class PageDataModel:HandyJSON{
    
    
    var items:[ItemsModel]?
    
    required init() {
        
        
    }
}

class ItemsModel:HandyJSON{
    
    var name:String = ""
    var type:String = ""
    var data:[DetailModel]?
    
    
    required init() {
        
        
    }
}

class DetailModel:HandyJSON{
    
    var imgUrl:String?
    var imgName:String?
    var link:[String:Any] = [:]
    var text:String?
    
    var goods_id:String?
    var goods_image:String?
    var goods_price_max:String?
    var goods_price_min:String?
    var goods_name:String?
    var goods_sales:String?
    
    required init() {
        
    }
}
