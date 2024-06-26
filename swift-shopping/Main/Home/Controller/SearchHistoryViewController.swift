//
//  SearchHistoryViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import UIKit

class SearchHistoryViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate,UITextFieldDelegate {
   
    var data:Array<String>? = []

    var collectionView:UICollectionView?
    @IBOutlet weak var searchField: UITextField!
    
    
    @IBOutlet weak var butt: UIButton!
    
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "商品搜索"
        
        self.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.initData()
    }

    func initView() -> Void {
        
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.masksToBounds = true
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        self.collectionView = UICollectionView(frame: CGRect(x: 15, y: 150, width: ScreenWidth-30, height: ScreenHeight-150-NavigationBarHeight), collectionViewLayout: layout)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.view.addSubview(self.collectionView!)
        self.collectionView?.register(UINib.init(nibName: "SearchHistoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchHistoryCollectionViewCell")
        
        self.searchField.returnKeyType = UIReturnKeyType.done
        self.searchField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.searchField.resignFirstResponder()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SearchHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionViewCell", for: indexPath) as! SearchHistoryCollectionViewCell
        
        let str = self.data?[indexPath.row]
        cell.megLab.text = str
        return cell
    }
    
    func initData() -> Void {
        
        let key:String = UserDefaults.standard.object(forKey: "searchListKey") as! String
        
        if ( key.count > 0){
            
            let data:Array<String> = key.components(separatedBy: "%=%")
            
            self.data = data
            self.collectionView?.reloadData()
        }
    }
   
    
    @IBAction func searchButtAc(_ sender: Any) {
        
        let text = self.searchField.text ?? ""
        
        if text.count > 0 {
            
            self.data?.insert(text, at: 0)
            
            //baocun
            let str = self.data?.joined(separator: "%=%")
            
            UserDefaults.standard.set(str, forKey: "searchListKey")
            self.collectionView?.reloadData()
        }
        
        //go list
        
    }
    
    
    
    @IBAction func clearButtAc(_ sender: Any) {
        
        
        self.view.makeToast("是否确定要清除全部的历史记录", point: CGPoint(x: 90, y: 90), title: "温馨提示", image: nil) { didTap in
            
            
            
        }
        
    }
    
}
