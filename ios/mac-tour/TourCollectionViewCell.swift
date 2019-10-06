//
//  TourTableViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 18/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class TourCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: Properties.
    let TourImageView = UIImageView()
    var TourImage: UIImage? {
        didSet {
            TourImageView.image = TourImage
            ActivityIndicator.stopAnimating()
        }
    }
    let TourNameLabel = UITextView()
    var TourName: String! {
        didSet {
            TourNameLabel.text = TourName
        }
    }
    let TourDistLabel = UITextView()
    var TourDist: Int! {
        didSet {
            TourDistLabel.text = "\(String(TourDist)) m"
        }
    }
    let TourContentTypeTextField = UITextView()
    var TourContentType: Int! {
        didSet {
            var TourContentString: String!
            switch self.TourContentType {
            case 12:
                TourContentString = "관광"
            case 14:
                TourContentString = "문화"
            case 15:
                TourContentString = "행사"
            case 32:
                TourContentString = "숙박"
            case 38:
                TourContentString = "쇼핑"
            case 39:
                TourContentString = "맛집"
            default:
                TourContentString = "관광"
            }
            TourContentTypeTextField.text = TourContentString
        }
    }
    var TourId: Int!
    let ActivityIndicator = UIActivityIndicatorView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 10.0
        self.backgroundView?.addSubview(ActivityIndicator)
        
        ActivityIndicator.startAnimating()
        
        //MARK: Tour Image
        self.contentView.addSubview(TourImageView)
        self.contentView.autoresizesSubviews = true
        
        TourImageView.translatesAutoresizingMaskIntoConstraints = false
        TourImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        TourImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
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
//        TourNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
//        TourNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        TourNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        TourNameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        TourNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
//        TourNameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10.0).isActive = true
        TourNameLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        TourNameLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 1.0).isActive = true
        
        
        TourNameLabel.contentMode = .center
        TourNameLabel.textColor = .white
        TourNameLabel.font = UIFont.init(name: "BM DOHYEON OTF", size: 40.0)
//        TourNameLabel.clipsToBounds = true
        TourNameLabel.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
//        TourNameLabel.layer.borderWidth = 1.0
        TourNameLabel.layer.cornerRadius = 10.0

        
        TourNameLabel.isUserInteractionEnabled = false
        TourNameLabel.isOpaque = true
        
        //MARK: Tour Distance.
//        TourDistLabel.font = UIFont(name: "System", size: 100.0)
        TourDistLabel.textColor = .black
        TourDistLabel.font = UIFont.init(name: "BM DOHYEON OTF", size: 30.0)
        TourDistLabel.textAlignment = .center
        
//        self.contentView.addSubview(TourDistLabel)
//        TourDistLabel.translatesAutoresizingMaskIntoConstraints = false
//        TourDistLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
//        TourDistLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
//        TourDistLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4).isActive = true
//        TourDistLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//        TourDistLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
//        TourDistLabel.isUserInteractionEnabled = false
//        TourDistLabel.layer.cornerRadius = 10.0
//        TourDistLabel.contentMode = .center
        
        //MARK: Tour Content Type
        self.contentView.addSubview(TourContentTypeTextField)
        TourContentTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        TourContentTypeTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        TourContentTypeTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        TourContentTypeTextField.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        TourContentTypeTextField.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//        TourContentTypeTextField.textInputView.centerYAnchor.constraint(equalTo: self.TourContentTypeTextField.centerYAnchor, constant: -100.0).isActive = true
        TourContentTypeTextField.textInputView.centerXAnchor.constraint(equalTo: self.TourContentTypeTextField.centerXAnchor).isActive = true
        
        TourContentTypeTextField.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        TourContentTypeTextField.font = UIFont.init(name: "BM DOHYEON OTF", size: 30.0)
        TourContentTypeTextField.textColor = .white
        TourContentTypeTextField.textAlignment = .center
        TourContentTypeTextField.layer.cornerRadius = 10.0
        TourContentTypeTextField.isUserInteractionEnabled = false
        TourContentTypeTextField.contentMode = .center
        
        print("tour cell created")
    }
}
