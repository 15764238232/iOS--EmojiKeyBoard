//
//  EmojiCollectionViewCell.swift
//  EasyChatBar
//
//  Created by DSY on 2017/7/14.
//  Copyright © 2017年 DSY. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emojilabel: UILabel!

    override func awakeFromNib() {

        switch UIScreen.main.bounds.width {
        case 375:
            emojilabel.font = UIFont.systemFont(ofSize: 26)
            break
        case 414:
            emojilabel.font = UIFont.systemFont(ofSize: 28)
            break
        default:
            break
        }
        super.awakeFromNib()
       
    }

}
