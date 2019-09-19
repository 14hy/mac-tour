//
//  TourTableViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 18/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class TourCollectionViewCell: UICollectionViewCell {
    
    let TourImageView = UIImageView()
    var TourImage: UIImage? {
        didSet {
            TourImageView.image = TourImage
        }
    }
    let TourNameLabel = UITextField()
    var TourName: String! {
        didSet {
            TourNameLabel.text = TourName
        }
    }
    let TourDistLabel = UITextField()
    var TourDist: Int! {
        didSet {
            TourDistLabel.text = "\(String(TourDist)) m"
        }
    }
    let TourContentTypeTextField = UITextField()
    var TourContentType: Int! {
        didSet {
            TourContentTypeTextField.text = String(TourContentType)
        }
    }
    var TourId: Int!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: Tour Image
        self.contentView.addSubview(TourImageView)
        self.contentView.autoresizesSubviews = true
        
        TourImageView.translatesAutoresizingMaskIntoConstraints = false
        TourImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        TourImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20.0).isActive = true
        TourImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        TourImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        
        TourImageView.contentMode = .scaleAspectFill
        TourImageView.clipsToBounds = true
        
        
        //MARK: Tour Name
        TourNameLabel.textAlignment = .center
        
        
        
        self.contentView.addSubview(TourNameLabel)
        TourNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        TourNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
//        TourNameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        TourNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        TourNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        TourNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        TourNameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        TourNameLabel.contentMode = .center
        TourNameLabel.adjustsFontSizeToFitWidth = true
        TourNameLabel.textColor = .black
        TourNameLabel.font = .boldSystemFont(ofSize: 100.0)
        TourNameLabel.clipsToBounds = true
        TourNameLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        TourNameLabel.borderStyle = .roundedRect
        TourNameLabel.isUserInteractionEnabled = false
        
        //MARK: Tour Distance.
//        TourDistLabel.font = UIFont(name: "System", size: 100.0)
        TourDistLabel.textColor = .black
        TourDistLabel.font = .boldSystemFont(ofSize: 50.0)
        
        self.contentView.addSubview(TourDistLabel)
        TourDistLabel.translatesAutoresizingMaskIntoConstraints = false
        TourDistLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        TourDistLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10.0).isActive = true
        TourDistLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        TourDistLabel.borderStyle = .roundedRect
        TourDistLabel.isUserInteractionEnabled = false
        
        //MARK: Tour Content Type
        self.contentView.addSubview(TourContentTypeTextField)
        TourContentTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        TourContentTypeTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10.0).isActive = true
        TourContentTypeTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10.0).isActive = true
        TourContentTypeTextField.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        TourContentTypeTextField.borderStyle = .roundedRect
        TourContentTypeTextField.adjustsFontSizeToFitWidth = true
        TourContentTypeTextField.font = .boldSystemFont(ofSize: 30.0)
        TourContentTypeTextField.textColor = .black
        TourContentTypeTextField.isUserInteractionEnabled = false
        
        
        
        
        print("tour cell created")
    }
}
