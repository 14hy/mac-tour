//
//  BreweryTableViewCell.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 12/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class BreweryTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //MARK: Properties
//    let PageView = 
    @IBOutlet weak var BreweryImageView: UIImageView!
    @IBOutlet weak var BreweryRegionTag: UITextField!
    @IBOutlet weak var BreweryNameTextView: UITextView!
    var BreweryName: String? {
        didSet {
            print("setting Brewery Name..")
            BreweryNameTextView.text = self.BreweryName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 10.0
        
        BreweryNameTextView.layer.cornerRadius = 10.0
        self.contentView.backgroundColor = .quaternarySystemFill
        self.BreweryImageView.backgroundColor = .quaternarySystemFill
        
        // 버튼의 background 가 가려지는 것을 방지합니다.
        self.selectionStyle = .none
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    private func setUp() {
        
    }
    
    
    

}
