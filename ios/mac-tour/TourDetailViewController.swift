//
//  TourDetailViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 2019/10/07.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class TourDetailViewController: UIViewController {
    
    //MARK: data
    struct info {
        let infoname: String!
        let infotext: String!
    }
    struct image {
        let smallimageurl: String!
        let originimgurl: String!
        let image: UIImage?
    }
    
    
    //MARK: Properties
    let InfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var infoCollectionCellHeight = [CGFloat?]()
    var infoCells = [TourInfoCollectionViewCell?]()
    
    @IBOutlet weak var PictureCollectionView: UICollectionView!
    @IBOutlet weak var AcitivityIndicator: UIActivityIndicatorView!
    let NoDataTextView = UILabel()
    
    var contentId: Int!
    var contentTypeId: Int!
    
    var contentInfo = [info?]()
    var contentImage = [image?]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: PictureCollectionView setup
        PictureCollectionView.layer.shadowOffset = .init(width: 0, height: 0)
        PictureCollectionView.layer.shadowOpacity = 0.5
        PictureCollectionView.layer.shadowColor = UIColor.label.cgColor
        PictureCollectionView.layer.shadowRadius = 1.0
        
        //MARK: InfoCollectionView setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //UICollectionViewFlowLayoutDelegate 는 UICollectionViewDelegate를 상속받기 때문에, 따로 지정해주지 않아도 된다.
        InfoCollectionView.collectionViewLayout = layout
        InfoCollectionView.collectionViewLayout.invalidateLayout()
        InfoCollectionView.backgroundColor = .systemBackground
        InfoCollectionView.layer.shadowColor = UIColor.label.cgColor
        InfoCollectionView.layer.shadowOffset = .init(width: 0, height: 0)
        InfoCollectionView.layer.shadowRadius = 1.5
        InfoCollectionView.layer.shadowOpacity = 0.5
        InfoCollectionView.layer.masksToBounds = false

        InfoCollectionView.register(TourInfoCollectionViewCell.self, forCellWithReuseIdentifier: "TourInfoCell")
        InfoCollectionView.tag = 2
        
        PictureCollectionView.delegate = self
        PictureCollectionView.dataSource = self
        
        InfoCollectionView.delegate = self
        InfoCollectionView.dataSource = self
        
        self.view.addSubview(InfoCollectionView)
        InfoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        InfoCollectionView.topAnchor.constraint(equalTo: self.PictureCollectionView.bottomAnchor, constant: 5.0).isActive = true
        InfoCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        InfoCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        InfoCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0).isActive = true
        
        //MARK: Fetch data from server
        
        Server.getTourPage(contentId, dataType: "info", activityIndicator: AcitivityIndicator, ContentTypeId: contentTypeId) {data in
            
            guard let data = data.array else {
                print("no data? \(self.contentId), \(self.contentTypeId)")
                return
            }
           
            for each in data {
                self.contentInfo.append(info(infoname: each["infoname"].string, infotext: each["infotext"].string))
            }
            self.InfoCollectionView.reloadData()
            print(self.contentInfo)
        }
        Server.getTourPage(contentId, dataType: "image", activityIndicator: AcitivityIndicator, ContentTypeId: nil) {data in
            guard let data = data.array else {
                return
            }
            for each in data {
                
                Server.getImg(each["originimgurl"].string!) {img in
                    self.contentImage.append(image(smallimageurl: each["smallimageurl"].string, originimgurl: each["originimgurl"].string, image: img))
                    self.PictureCollectionView.reloadData()
                }
            }
            print("reload PictureCollectionView")
            self.PictureCollectionView.reloadData()
            print(self.contentImage)
        }
        //MARK: NO DATALABEL
        NoDataTextView.text = "상세정보가 없습니다."
        NoDataTextView.textAlignment = .center
        NoDataTextView.font = .boldSystemFont(ofSize: 25.0)
        NoDataTextView.textColor = .label
        
        self.view.addSubview(NoDataTextView)
        NoDataTextView.translatesAutoresizingMaskIntoConstraints = false
        NoDataTextView.topAnchor.constraint(equalTo: self.PictureCollectionView.bottomAnchor, constant: 10.0).isActive = true
        NoDataTextView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        NoDataTextView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        NoDataTextView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        
        //MARK: Do any additional setup after loading the view.
        
        AcitivityIndicator.startAnimating()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TourDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionViewTag: Int = collectionView.tag
        
        if collectionViewTag == 1 {
            // Picture collection view
            return contentImage.count
        }
        else {
            // info collection view
            print("contentInfo.count \(contentInfo.count)")
            if contentInfo.count > 0 {
                NoDataTextView.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
            }
            if self.contentTypeId == 32 {
                return 0
            }
            return contentInfo.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionViewTag: Int = collectionView.tag
        if collectionViewTag == 1 {
            print("TourPictureCell: \(indexPath.row)")
            // Picture collection view
            let cell = PictureCollectionView.dequeueReusableCell(withReuseIdentifier: "TourPictureCell", for: indexPath)
            cell.contentMode = .scaleAspectFill
            cell.contentView.layer.borderColor = UIColor.label.cgColor
            cell.contentView.layer.borderWidth = 1.0
            
            cell.layer.cornerRadius = 10.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.shadowOffset = .init(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.label.cgColor
            
            
            if self.contentImage.count > indexPath.row {
                let imageView = UIImageView(image: self.contentImage[indexPath.row]?.image!)
                imageView.layer.cornerRadius = 10.0
                cell.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
                imageView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
                imageView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor).isActive = true
            }
    
            return cell
        }
        else {
            print("TourInfoCell: \(indexPath.row)")
            guard let cell = self.InfoCollectionView.dequeueReusableCell(withReuseIdentifier: "TourInfoCell", for: indexPath) as? TourInfoCollectionViewCell else {
                fatalError("TourInfoCollectionViewCell downcasting error")
            }
            cell.name = self.contentInfo[indexPath.row]!.infoname
            cell.text = self.contentInfo[indexPath.row]!.infotext
            let height = cell.infonameView.frame.height + cell.infotextView.frame.height + 50
            self.infoCollectionCellHeight.append(height)
            print("for each in data \(self.infoCells.count)")
            print("self.contentInfo.count \(self.contentInfo.count)")
            cell.sizeToFit()
            return cell
        }
    }
}

extension TourDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewTag: Int = collectionView.tag
        if collectionViewTag == 1 {
            // Picture collection view
            return CGSize(width: 250.0, height: self.PictureCollectionView.frame.height)
        }
        else {
            print("setting info collection view")
            // info collection view
//            let height = self.infoCollectionCellHeight[indexPath.row]!
            print(self.infoCollectionCellHeight)
            if self.infoCollectionCellHeight.count > indexPath.row {
                return CGSize(width: self.PictureCollectionView.frame.width, height: self.infoCollectionCellHeight[indexPath.row]!)
            }else {
                return CGSize(width: self.PictureCollectionView.frame.width, height: 125.0)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 20.0
//    }
}
