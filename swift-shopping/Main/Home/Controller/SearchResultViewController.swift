//
//  SearchResultViewController.swift
//  swift-shopping
//
//  Created by 程广成 on 2024/6/26.
//

import UIKit
import MJRefresh

class SearchResultViewController: BaseViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
   
    var goodsName:String = ""
    var sortType:String = "all"
    var sortPrice:String = "0"
    var categoryId:String = ""
    var page = 1
    
    var data:Array<Any>?
    var tableView:UITableView?
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "商品列表"
        self.initView()
        self.initData()
    }

    func initView() -> Void {
        
        self.bgView.layer.cornerRadius = 10
        self.textField.delegate = self
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 120, width: ScreenWidth, height: ScreenHeight-NavigationBarHeight-120), style: .grouped)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.view.addSubview(self.tableView!)
        
        self.tableView?.register(UINib.init(nibName: "GoodsListTableViewCell", bundle: nil), forCellReuseIdentifier: "GoodsListTableViewCell")
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.page = 1
            self.initData()
        })
        self.tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.page += 1
            self.initData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:GoodsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GoodsListTableViewCell", for: indexPath) as! GoodsListTableViewCell
        
        guard let data = self.data?[indexPath.row] else { return cell }
        cell.setData(data: data as! DetailModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        
//        self.navigationController?.popViewController(animated: false)
//        return false
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    func initData() -> Void {
        
        let param:[String:Any] = [
        
            "page":self.page,
            "categoryId":self.categoryId,
            "sortType":self.sortType,
            "sortPrice":self.sortPrice,
            "goodsName":self.goodsName
        ]
        self.showLoadingView()
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/goods/list",parameters: param) { request, responseData in
            
            self.hiddenLoadingView()
            self.tableView?.mj_header?.endRefreshing()
            self.tableView?.mj_footer?.endRefreshing()
            let model:GoodsListModel = GoodsListModel.deserialize(from: responseData as? [String:Any]) ?? GoodsListModel()
            
            if model.status == 200 {
                
                let data = model.data?.list?.data
                if self.page == 1{
                    
                    self.data = data
                }else{
                    
                    self.data?.append(contentsOf: data ?? [])
                }
                if (data?.count ?? 0 < 15){
                    
                    self.tableView?.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.tableView?.reloadData()
            }
        }
        
    }

    @IBAction func leftButtAc(_ sender: Any) {
        self.page = 1
        self.sortType = "all"
        self.initData()
    }
    
    @IBAction func centerButtAc(_ sender: Any) {
        self.page = 1
        self.sortType = "sales"
        self.initData()
    }
    
    @IBAction func rightButtAc(_ sender: Any) {
        self.page = 1
        self.sortType = "price"
        self.initData()
    }
    
}
