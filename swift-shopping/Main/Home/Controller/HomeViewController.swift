//
//  HomeViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit
import HandyJSON

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var homeModel:HomeModel?
    var tableView:UITableView?
    var data:Array<DetailModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        
        self.view.backgroundColor = UIColor.lightGray
        initView()
        initData()
    }
    
    func initView() -> Void {
        
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.tableView?.register(UINib.init(nibName: "GoodsListTableViewCell", bundle: nil), forCellReuseIdentifier: "GoodsListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GoodsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoodsListTableViewCell", for: indexPath) as! GoodsListTableViewCell
        
        guard let data = self.data?[indexPath.row] else { return cell }
        cell.setData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func initData() -> Void {
        
        let config = LNNetworkConfiguration(baseURL: URL(string: "1"))
            
         LNNetworkManager.default.configuration = config
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/page/detail") { request, responseData in
            
            if let model = HomeModel.deserialize(from: responseData as? [String:Any]){
                self.homeModel = model
                self.data = model.data?.pageData?.items?[6].data
                self.tableView?.reloadData()
            }
            
//            let data:[String:Any] = responseData as! [String : Any]
//            let pageData:[String:Any] = data["data"] as! [String : Any]
//            let pageData2:[String:Any] = pageData["pageData"] as! [String : Any]
//            let items:[Any] = pageData2["items"] as! [Any]
//            print(items)
//
//            if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) {
//                if let jsonString = String(data: jsonData, encoding: .utf8) {
//                    print(jsonString) // 输出 JSON 字符串
//                    
//                    
//            }
                
                
            }
        }
    
    
    
    
}
