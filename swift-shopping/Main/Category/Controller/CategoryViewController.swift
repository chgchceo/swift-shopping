//
//  CategoryViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class CategoryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cModel:CategoryModel?

    @IBOutlet weak var searchButt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "分类"
        self.initView()
        self.initData()
    }
    

    func initView() -> Void {
        
        self.searchButt.layer.cornerRadius = 22
        self.searchButt.layer.masksToBounds = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func initData() -> Void {
        
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/category/list", success: {request,res  in
            
            let model:CategoryModel = CategoryModel.deserialize(from: res as? [String:Any])!
            
            if(model.status == 200){
                
                self.cModel = model
                self.tableView.reloadData()
            }
        })
    }

    @IBAction func searchButtAc(_ sender: Any) {
        
        let historyVc = SearchHistoryViewController()
        
        historyVc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(historyVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return (self.cModel?.data?.list!.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = UITableViewCell()
        let model:CategoryListModel = (self.cModel?.data?.list?[indexPath.row])!
        cell.textLabel?.text = model.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.textColor = UIColor.gray
        cell.backgroundColor = UIColor.groupTableViewBackground
        
        return cell
    }
}
