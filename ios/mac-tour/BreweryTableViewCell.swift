//
//  BreweryTableViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 12/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var BreweryImageView: UIImageView!
    let BreweryNameLabel = UIButton()
    @IBOutlet weak var BreweryRegionTag: UITextField!
    
    var BreweryName: String? {
        didSet {
            BreweryNameLabel.setTitle(self.BreweryName, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        BreweryNameLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        BreweryNameLabel.setTitleColor(.white, for: .normal)
//        BreweryNameLabel
        BreweryNameLabel.layer.cornerRadius = 10.0
//        BreweryNameLabel.font = .boldSystemFont(ofSize: 500.0)
        BreweryNameLabel.isUserInteractionEnabled = false
//        BreweryNameLabel.adjustsFontSizeToFitWidth = true
        BreweryNameLabel.tintColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
        self.contentView.addSubview(BreweryNameLabel)
        BreweryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        BreweryNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        BreweryNameLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        BreweryNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30.0).isActive = true
//        BreweryNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30.0).isActive = true
//        BreweryNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
//        BreweryNameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
    }
    
    

}
