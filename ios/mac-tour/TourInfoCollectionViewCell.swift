//
//  TourPicturesCollectionViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 2019/10/07.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class TourInfoCollectionViewCell: UICollectionViewCell {
    
    let infonameView = UILabel()
    let infotextView = UITextView()
    
    var name: String? {
        didSet {
            infonameView.text = self.name
            infonameView.sizeToFit()
            print("infonameView.frame.height \(infonameView.frame.height)")
        }
    }
    var text: String? {
        didSet {

            infotextView.text = self.text
            infotextView.sizeToFit()
            print("infotextView.frame.height \(infotextView.frame.height)")
            infotextView.bottomAnchor.constraint(equalTo: self.infotextView.topAnchor, constant: infotextView.frame.height).isActive = true
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        print("TourInfoCollectionViewCell ")
        self.contentView.layer.shadowColor = UIColor.label.cgColor
        self.contentView.layer.shadowOffset = .init(width: 0, height: 0)
        self.contentView.layer.shadowOpacity = 0.5
        self.contentView.layer.shadowRadius = 3.0
        self.contentView.backgroundColor = .systemBackground
        
//        infonameView.text = "infonameView"
        infonameView.font = .systemFont(ofSize: 25.0)
        infonameView.textColor = .blue
        
        self.addSubview(infonameView)
        
        infonameView.translatesAutoresizingMaskIntoConstraints = false
        infonameView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 5.0).isActive = true
        infonameView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5.0).isActive = true
        infonameView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        let dividerView = UIView()
        dividerView.backgroundColor = .systemGray3
        
        self.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.topAnchor.constraint(equalTo: infonameView.bottomAnchor, constant: 5.0).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
//        dividerView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width - 30.0).isActive = true
        dividerView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        
        infotextView.backgroundColor = .systemBackground
//        infotextView.text = "infotextView"
        
        self.addSubview(infotextView)
        infotextView.translatesAutoresizingMaskIntoConstraints = false
        infotextView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 5.0).isActive = true
        infotextView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        infotextView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        infotextView.widthAnchor.constraint(equalTo: dividerView.widthAnchor).isActive = true
        
        
        
    }
}
