//
//  HomeBannerView.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/25.
//

import UIKit
import JXBanner

class HomeBannerView: UIView {
   
    
    var data:Array<Any>?
    
    lazy var bannerView: JXBanner = {
        
        let bannerView = JXBanner()
        bannerView.backgroundColor = UIColor.black
        bannerView.placeholderImgView.image = UIImage(named: "banner_placeholder")
        bannerView.delegate = self
        bannerView.dataSource = self

        return bannerView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.initView()
    }
    
    func initView() -> Void {
        
        self.addSubview(self.bannerView)
        self.bannerView.frame = CGRectMake(0, 0, ScreenWidth, 200)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBannerData(data:Array<Any>) -> Void {
        
        self.data = data
        self.bannerView.reloadView()
    }
}


//MARK:- JXBannerDataSource
extension HomeBannerView: JXBannerDataSource {
   
   
    
    // 注册重用Cell标识
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
                                        reuseIdentifier: "JXDefaultVCCell")
    }
    
    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int {
            return self.data?.count ?? 0
        }
    
    func jxBanner(_ banner: JXBannerType, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        
        let tempCell: JXBannerCell = cell as! JXBannerCell
        tempCell.layer.cornerRadius = 8
        tempCell.layer.masksToBounds = true
        var model:DetailModel = self.data![index] as! DetailModel
        tempCell.imageView.image = UIImage(named: "banner_placeholder")
        tempCell.imageView.sd_setImage(with: URL(string: model.imgUrl ?? ""))
//        tempCell.msgLabel.text = String(index) + "---来喽来喽,他真的来喽~"
        
        return tempCell
    }
    
    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType,
                  layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
        return layoutParams
            .itemSize(CGSize(width: UIScreen.main.bounds.width, height: 200))
            .itemSpacing(0)
    }
}

//MARK:- JXBannerDelegate
extension HomeBannerView: JXBannerDelegate {
    
    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
                         didSelectItemAt index: Int) {
        print(index)
    }
    
}
