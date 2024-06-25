//
//  HomeCollectionView.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import UIKit

class HomeCollectionView: UIView, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
   
    var collectionView:UICollectionView?
    
    var data:Array<Any>?
   
    override init(frame: CGRect) {
        
        
        super.init(frame: frame)
        
        self.initView()
        
    }
    
    
    func initView() -> Void {
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        self.addSubview(self.collectionView!)
        
        self.collectionView?.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        return cell
    }
    

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
