//
//  HomeViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit
import HandyJSON
import MJRefresh

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var searchBtn: UIButton!
    var homeModel:HomeModel?
    var tableView:UITableView?
    var data:Array<DetailModel>?
    var headerView:UIView?
    var bannerView:HomeBannerView? = HomeBannerView()
    var collectionView:HomeCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        
        initView()
        self.tableView?.mj_header?.beginRefreshing()
    }
    
    func initView() -> Void {
        
        self.searchBtn.layer.cornerRadius = 22
        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 60, width: ScreenWidth, height: ScreenHeight-NavigationBarHeight-TabBarHeight), style: .grouped)
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.tableView?.register(UINib.init(nibName: "GoodsListTableViewCell", bundle: nil), forCellReuseIdentifier: "GoodsListTableViewCell")
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.initData()
        })
        
        self.tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            self.tableView?.mj_footer?.endRefreshingWithNoMoreData()
        })
    }
    
    func refreshHeaderView() -> Void {
        
        let bannerData = self.homeModel?.data?.pageData?.items?[1].data
        let categoryData = self.homeModel?.data?.pageData?.items?[3].data
        
        var height = 0
        if bannerData?.count ?? 0 > 0{
            
            self.headerView = UIView()
            self.headerView?.addSubview(self.bannerView!)
            self.bannerView?.setBannerData(data: bannerData!)
            self.bannerView?.backgroundColor = UIColor.orange
            self.bannerView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
            height += 200
        }
        
        if categoryData?.count ?? 0 > 0{
            
            if height == 0{
                
                self.headerView = UIView()
            }
            if (self.collectionView == nil){
                
                self.collectionView = HomeCollectionView(frame: CGRect(x: 0, y: height, width: Int(ScreenWidth), height: 200))
            }
            self.collectionView?.backgroundColor = UIColor.green
            self.headerView?.addSubview(self.collectionView!)
            self.collectionView?.setData(data: categoryData!)
            self.collectionView?.frame = CGRect(x: 0, y: height, width: Int(ScreenWidth), height: 200)
            height += 200
        }
        
        if height > 0  {
            
            self.headerView?.frame = CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: height)
            self.tableView?.tableHeaderView = self.headerView
            self.headerView?.backgroundColor = UIColor.white
            self.tableView?.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVc = GoodsDetailViewController()
        detailVc.hidesBottomBarWhenPushed = true
        let data:DetailModel = (self.data?[indexPath.row])!
        detailVc.goodsId = data.goods_id
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return nil
    }
    
    func initData() -> Void {
        
        
        self.showLoadingView()
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/page/detail") { request, responseData in
            
            if let model = HomeModel.deserialize(from: responseData as? [String:Any]){
                self.homeModel = model
                self.data = model.data?.pageData?.items?[6].data
                self.tableView?.reloadData()
                self.refreshHeaderView()
            }
            self.tableView?.mj_header?.endRefreshing()
            self.hiddenLoadingView()
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
    
    
    
    @IBAction func searchButtAc(_ sender: Any) {
        
        let historyVc = SearchHistoryViewController()
        
        historyVc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(historyVc, animated: true)
    }
    
}
