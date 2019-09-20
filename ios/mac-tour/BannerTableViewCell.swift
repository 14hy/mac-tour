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
    var banners = [ViewController.banner?]()
    
    let PageControl = UIPageControl()
    let BannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: Attributes.
    var numberOfPages: Int! {
        didSet {
            PageControl.numberOfPages = self.numberOfPages
        }
    }
    var currentPage: Int! {
        didSet {
            PageControl.currentPage = self.currentPage
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BannerPageControl.numberOfPages = 0
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        
        //MARK: UICollectionVIew.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
//        layout.itemSize = CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 0.0
        BannerCollectionView.isPagingEnabled = true
        
        BannerCollectionView.collectionViewLayout = layout
        BannerCollectionView.backgroundColor = .red
        BannerCollectionView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(BannerCollectionView)
        BannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        BannerCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        BannerCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        BannerCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        BannerCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        BannerCollectionView.delegate = self
        BannerCollectionView.dataSource = self
        BannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        //MARK: UIPageControlView.
        
        PageControl.numberOfPages = 1
        PageControl.currentPage = 0
        
        self.contentView.addSubview(PageControl)
        PageControl.translatesAutoresizingMaskIntoConstraints = false
        PageControl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0).isActive = true
        PageControl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Banner count: \(self.banners.count)")
        self.numberOfPages = self.banners.count
        return self.banners.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("BannerSelect \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.BannerCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BannerCollectionViewCell else {
            fatalError("!")
        }
        cell.clipsToBounds = true
        cell.image = self.banners[indexPath.row]!.image
        
        debugPrint(BannerCollectionView.indexPathsForVisibleItems)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentPage = indexPath.row
    }
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("moveItemAt \(sourceIndexPath)|\(destinationIndexPath)")
//        currentPage = destinationIndexPath.row
//    }
    
}
