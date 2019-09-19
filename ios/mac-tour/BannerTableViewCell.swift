//
//  BannerTableViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 12/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var BannerImageView: UIImageView!
    @IBOutlet weak var BannerPageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BannerPageControl.numberOfPages = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
