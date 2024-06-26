//
//  SearchHistoryViewController.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import UIKit

class SearchHistoryViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    

    var collectionView:UICollectionView?
    @IBOutlet weak var searchField: UITextField!
    
    
    @IBOutlet weak var butt: UIButton!
    
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "商品搜索"
        
        self.initView()
    }


    func initView() -> Void {
        
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.masksToBounds = true
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        self.collectionView = UICollectionView(frame: CGRect(x: 15, y: 100, width: ScreenWidth-30, height: ScreenHeight), collectionViewLayout: layout)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.view.addSubview(self.collectionView!)
        self.collectionView?.register(UINib.init(nibName: "SearchHistoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchHistoryCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:SearchHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionViewCell", for: indexPath) as! SearchHistoryCollectionViewCell
        
        
        return cell
    }
    
   
}
