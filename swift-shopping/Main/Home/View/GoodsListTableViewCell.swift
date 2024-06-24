//
//  GoodsListTableViewCell.swift
//  swift-shopping
//
//  Created by cheng on 2024/6/24.
//

import UIKit
import SDWebImage

class GoodsListTableViewCell: UITableViewCell {

    
    var data:DetailModel?
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    @IBOutlet weak var priceLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setData(data:DetailModel) -> Void {
        
        self.data = data
        
        self.imgView.sd_setImage(with: URL(string: self.data?.goods_image! ?? ""))
        self.titleLab.text = data.goods_name
        self.priceLab.text = data.goods_price_min
        
    }
}
