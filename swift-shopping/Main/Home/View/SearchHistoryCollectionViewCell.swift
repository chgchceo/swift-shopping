//
//  SearchHistoryCollectionViewCell.swift
//  swift-shopping
//
//  Created by 程广成 on 2024/6/26.
//

import UIKit

class SearchHistoryCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var megLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.megLab.layer.cornerRadius = 20
        self.megLab.layer.borderWidth = 1
        self.megLab.layer.borderColor = HexRGBAlpha(0xf7f7f7,1).cgColor
    }

}
