//
//  CategoryViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit

class CategoryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var cModel:CategoryModel?

    @IBOutlet weak var searchButt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var currentIndex:Int = 0
    
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
        self.tableView.separatorStyle = .none
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
    }
    
    func initData() -> Void {
        
        self.showLoadingView()
        LNRequest.get(path: "https://smart-shop.itheima.net/index.php?s=/api/category/list", success: {request,res  in
            
            let model:CategoryModel = CategoryModel.deserialize(from: res as? [String:Any])!
            
            self.hiddenLoadingView()
            if(model.status == 200){
                
                self.cModel = model
                self.tableView.reloadData()
                self.collectionView.reloadData()
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
        
        let cell:UITableViewCell = UITableViewCell()
        let model:CategoryListModel = (self.cModel?.data?.list?[indexPath.row])!
        cell.textLabel?.text = model.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.textColor = UIColor.gray
        cell.backgroundColor = HexRGBAlpha(0xf7f7f7, 1)
        if(indexPath.row == self.currentIndex){
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.red
        }
        cell.textLabel?.textAlignment = NSTextAlignment.center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentIndex = indexPath.row
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
    
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return self.cModel?.data?.list?[self.currentIndex].children?.count ?? 0
    }
    
    @available(iOS 8.0, *)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        
        
        let model:CategoryChildrenModel = self.cModel?.data?.list?[self.currentIndex].children?[indexPath.item] ?? CategoryChildrenModel()
        
        cell.megLab.text = model.name
        let imgUrl = model.image?.preview_url
        cell.imgView.sd_setImage(with: URL(string: imgUrl ?? ""))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model:CategoryChildrenModel = self.cModel?.data?.list?[self.currentIndex].children?[indexPath.item] ?? CategoryChildrenModel()
        
        let Id = String(model.category_id)
        let resultVc = SearchResultViewController()
        resultVc.hidesBottomBarWhenPushed = true
        resultVc.categoryId = Id
        self.navigationController?.pushViewController(resultVc, animated: true)
    }
    
}
