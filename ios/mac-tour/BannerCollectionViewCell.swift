//
//  BannerCollectionViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 21/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties.
    let imageView = UIImageView()
    var image: UIImage? {
        didSet {
            imageView.image = self.image
        }
    }
    //INIT
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    private func setUp() {
        
        
        //MARK: CELL
        self.contentView.contentMode = .scaleAspectFill
        
        //MARK: ImageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    
    
}
