//
//  CategoryModel.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import Foundation

class CategoryModel:BaseModel{
    
    
    var status:Int? = 0
    var message:String? = ""
    var data:CListModel?
}

class CListModel:BaseModel{
    
    var list:[CategoryListModel]?
}


class CategoryListModel:BaseModel{
    
    /*"category_id":10016,
     "name":"热门推荐",
     "parent_id":0,
     "image_id":0,
     "status":1,
     "sort":1,
     "children":[],
     "image":null*/
    var category_id:Int = 0
    var name:String = ""
    var children:[CategoryChildrenModel]?
    
}

class CategoryChildrenModel:BaseModel{
    
    
    var name:String = ""
    var image:CategoryImageModel?
    var category_id:Int = 0
    
}

class CategoryImageModel:BaseModel{
    
    var preview_url:String = ""
}
