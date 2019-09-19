//
//  CollectionViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 16/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

@IBDesignable
class CollectionViewController: UICollectionViewController {
    
    let cellIdentifier = "cellIdentifier"
//    let collectionView = UICollectionView()
    
    var layout = CollectionViewSlantedLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        
        
        //MARK: Setting collectionView
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BreweryCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: BreweryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BreweryCollectionViewCell else {
            fatalError("BreweryCollectionViewCell Fatal Error")
        }
        
//        cell.contentMode = .scaleAspectFit
        let image = UIImage(named: "brewery1")
        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFit
        cell.addSubview(imageView)
        
//        imageView.contentMode =
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView clicked! \(indexPath.row)")
    }
}

extension CollectionViewController: CollectionViewDelegateSlantedLayout {
    
}
