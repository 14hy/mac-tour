//
//  BreweryDetailViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 14/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit


enum contentType: String {
    case GwanGwang = "관광지"
    case MunHwa = "문화시설"
    case HangSa = "행사/축제"
    case SukBak = "숙박"
    case Shopping = "쇼핑"
    case Food = "맛집"
}

@IBDesignable
class BreweryDetailViewController: UIViewController {
    
    
    //MARK: Properties.
    let BreweryDetailStackView = UIStackView()
    let BreweryScrollView = UIScrollView()
    let BreweryBottomMenuStackView = UIStackView()
    let TourListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let DetailTextBox = UITextView()
    let BreweryImageView = UIImageView()
    let TourTagStackView = UIStackView()
    let TourTagStackView2 = UIStackView()
    var TourListViewVisibleCell: TourCollectionViewCell? {
        didSet {
            self.setTourMarketItem(TourListViewVisibleCell!)
        }
    }
    let TViewCurrentTourCell = TMapMarkerItem2()
    
    
    //Tmap
    let TViewPathData = TMapPathData()
    let TViewWrapper = UIView()
    let TView: TMapView! = TMapView()
    let TGpsManager: TMapGpsManager! = TMapGpsManager()
    let TMapMarkerItem: TMapMarkerItem2! = TMapMarkerItem2()
    var MapCircles = [TMapCircle?]()
//    var TourMarkerItems = [TMapMarkerItem2?]()
    
    //MARK: Attributes.
    let cornerRadius: CGFloat = 10.0
    let BreweryImage: UIImage? = nil
    
    //MARK: Datas.
    struct brewery {
        let name: String?
        var image: UIImage?
        let desc: String?
        let homePageUrl: String?
        let mapX: Double?
        let mapY: Double?
        let applyUrl: String?
        let price: Int?
        let availableDay: String?
    }
    struct tour {
        var image: UIImage?
        let contentType: Int?
        let dist: Int?
        let title: String?
        let contentId: Int?
        let mapX: Double?
        let mapY: Double?
    }
    
    struct DetailPage {
        var brewery: brewery?
        var tours: Array<tour?>
    }
    
    var curTmp: TMapPoint? {
        didSet {
            TView.setCenter(self.curTmp)
            TMapMarkerItem.setTMapPoint(curTmp)
            TView.resizeWidthFrame(CGRect(x: 0, y: 0, width: TViewWrapper.frame.size.width, height: TViewWrapper.frame.size.height))
        }
    }
    
    //MARK: BreweryDetail Assets.
    var BreweryName: String!
    var ContentTypeId: Int? {
        didSet {
            removeTours()
            setDetailPageContent()
        }
    }
    var content = DetailPage(brewery: nil, tours: [tour?]())
    
    private let ApiKey = "4175b58c-a656-46f6-b8f3-82ed9b46a517"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Setting ETC
        setDetailPageContent()
        TView.addTMapMarkerItemID("self.TViewCurrentTourCell", markerItem2: self.TViewCurrentTourCell)
        
        //MARK: Setting Bottom Menubar.
        let BreweryBottomMenuView = UIView() // Wrapping view
        BreweryBottomMenuView.backgroundColor = .black
        
        
        self.view.addSubview(BreweryBottomMenuView)
        BreweryBottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        BreweryBottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        BreweryBottomMenuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0).isActive = true
        BreweryBottomMenuView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        BreweryBottomMenuView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        BreweryBottomMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //Stack attributes.
        BreweryBottomMenuStackView.axis = .horizontal
        BreweryBottomMenuStackView.distribution = .fillEqually
        BreweryBottomMenuStackView.spacing = 10.0
        BreweryBottomMenuStackView.alignment = .center
        
        BreweryBottomMenuView.addSubview(BreweryBottomMenuStackView)
        BreweryBottomMenuStackView.translatesAutoresizingMaskIntoConstraints = false
        BreweryBottomMenuStackView.topAnchor.constraint(equalTo: BreweryBottomMenuView.topAnchor, constant: 0.0).isActive = true
        BreweryBottomMenuStackView.leadingAnchor.constraint(equalTo: BreweryBottomMenuView.leadingAnchor).isActive = true
        BreweryBottomMenuStackView.trailingAnchor.constraint(equalTo: BreweryBottomMenuView.trailingAnchor).isActive = true
        BreweryBottomMenuStackView.bottomAnchor.constraint(equalTo: BreweryBottomMenuView.bottomAnchor).isActive = true
        

        
        //MARK: 기타
        let tempButton = UIButton()
        tempButton.setTitle("크흠..", for: .normal)
        tempButton.setTitleColor(.purple, for: .normal)
        BreweryBottomMenuStackView.addArrangedSubview(tempButton)
        
        
        //MARK: 신청하기 버튼
        let applyButton = UIButton()
        applyButton.setTitle("신청하기", for: .normal)
        applyButton.setTitleColor(.purple, for: .normal)
        BreweryBottomMenuStackView.addArrangedSubview(applyButton)
        
        //MARK: Setting ScrollView.
        self.view.backgroundColor = .red
        BreweryScrollView.backgroundColor = .green
        
        self.view.addSubview(BreweryScrollView)
        BreweryScrollView.translatesAutoresizingMaskIntoConstraints = false
        BreweryScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        BreweryScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0).isActive = true
        BreweryScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0).isActive = true
        BreweryScrollView.bottomAnchor.constraint(equalTo: self.BreweryBottomMenuStackView.topAnchor, constant: 0.0).isActive = true
        
        //MARK: Setting BreweryDetailStackView
        BreweryDetailStackView.distribution = .fillProportionally
        BreweryDetailStackView.alignment = .fill
        BreweryDetailStackView.axis = .vertical
        BreweryDetailStackView.spacing = 10.0
        BreweryScrollView.addSubview(BreweryDetailStackView)
        BreweryDetailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        BreweryDetailStackView.widthAnchor.constraint(equalTo: BreweryScrollView.widthAnchor).isActive = true
        BreweryDetailStackView.topAnchor.constraint(equalTo: BreweryScrollView.topAnchor, constant: 0.0).isActive = true
        BreweryDetailStackView.leadingAnchor.constraint(equalTo: BreweryScrollView.leadingAnchor, constant: 0.0).isActive = true
        BreweryDetailStackView.trailingAnchor.constraint(equalTo: BreweryScrollView.trailingAnchor, constant: 0.0).isActive = true
        BreweryDetailStackView.bottomAnchor.constraint(equalTo: BreweryScrollView.bottomAnchor, constant: 0.0).isActive = true


        //MARK: Setting BreweryImageView
        BreweryImageView.contentMode = .scaleToFill
//        BreweryImageView.layer.borderWidth = 2.0
//        BreweryImageView.layer.borderColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        BreweryImageView.layer.cornerRadius = cornerRadius
        BreweryImageView.clipsToBounds = true
        
        BreweryDetailStackView.addArrangedSubview(BreweryImageView)
        //AutoLayout.
        BreweryImageView.translatesAutoresizingMaskIntoConstraints = false
        BreweryImageView.preservesSuperviewLayoutMargins = true
        BreweryImageView.topAnchor.constraint(equalTo: BreweryDetailStackView.topAnchor, constant: 0.0).isActive = true
        BreweryImageView.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
//        BreweryImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        BreweryImageView.bottomAnchor.constraint(equalTo: BreweryDetailStackView.topAnchor, constant: 250.0).isActive = true
        BreweryImageView.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        
        //MARK: Setting BreweryDetailMenuStackView
        let BreweryDetailMenuStackView = UIStackView()
        BreweryDetailMenuStackView.axis = .horizontal
        BreweryDetailMenuStackView.distribution = .fillEqually
        BreweryDetailMenuStackView.alignment = .fill
        BreweryDetailMenuStackView.spacing = 10.0
        BreweryDetailStackView.addArrangedSubview(BreweryDetailMenuStackView)
        //AutoLayout.
        BreweryDetailMenuStackView.translatesAutoresizingMaskIntoConstraints = false
        
        BreweryDetailMenuStackView.topAnchor.constraint(equalTo: BreweryImageView.bottomAnchor, constant: 10.0).isActive = true
        BreweryDetailMenuStackView.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
        BreweryDetailMenuStackView.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        BreweryDetailMenuStackView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        BreweryDetailMenuStackView.bottomAnchor.constraint(equalTo: BreweryDetailMenuStackView.topAnchor, constant: 40.0).isActive = true
        
        
        
        //MARK: Setting Buttons for Menu.
        BreweryDetailMenuStackView.addArrangedSubview(createButton("홈페이지"))
        BreweryDetailMenuStackView.addArrangedSubview(createButton("길 찾기"))
        BreweryDetailMenuStackView.addArrangedSubview(createButton("공유"))

        //MARK: Setting DetailTextBox.
        DetailTextBox.textColor = .black
        DetailTextBox.backgroundColor = .orange
        
        DetailTextBox.allowsEditingTextAttributes = false
        DetailTextBox.adjustsFontForContentSizeCategory = true
        DetailTextBox.isEditable = false
        DetailTextBox.isSelectable = false
        DetailTextBox.isUserInteractionEnabled = false
        DetailTextBox.textAlignment = .center
        DetailTextBox.font = .boldSystemFont(ofSize: 20.0)
        DetailTextBox.layer.cornerRadius = cornerRadius
        
        //AutoLayout.
        BreweryDetailStackView.addArrangedSubview(DetailTextBox)
        DetailTextBox.translatesAutoresizingMaskIntoConstraints = false
        DetailTextBox.topAnchor.constraint(equalTo: BreweryDetailMenuStackView.bottomAnchor, constant: 10.0).isActive = true
        DetailTextBox.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
        DetailTextBox.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        DetailTextBox.bottomAnchor.constraint(equalTo: DetailTextBox.topAnchor, constant: 300.0).isActive = true
        
        
        //MARK: Setting TMapView.
        TViewWrapper.contentMode = .scaleAspectFill
        TViewWrapper.backgroundColor = .darkGray
        TViewWrapper.layer.cornerRadius = cornerRadius
        
        //AutoLayout.
        BreweryDetailStackView.addArrangedSubview(TViewWrapper)
        TViewWrapper.translatesAutoresizingMaskIntoConstraints = false
        TViewWrapper.topAnchor.constraint(equalTo: DetailTextBox.bottomAnchor, constant: 10.0).isActive = true
        TViewWrapper.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
        TViewWrapper.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        TViewWrapper.bottomAnchor.constraint(equalTo: TViewWrapper.topAnchor, constant: 300.0).isActive = true
        //
        TViewWrapper.addSubview(TView)
        //
        TView.delegate = self
        TView.layer.cornerRadius = 10.0
        TView.gpsManagersDelegate = self
        TView.setZoomLevel(14)
        TView.addTMapMarkerItemID("curLocationMarkerItem", markerItem2: TMapMarkerItem)
        TView.setTMapTileType(NORMALTILE)
        TView.setSKTMapApiKey(ApiKey)
//        TView.setTrackingMode(true)
        //AutoLayout.
        TView.translatesAutoresizingMaskIntoConstraints = false
        TView.topAnchor.constraint(equalTo: TViewWrapper.topAnchor).isActive = true
        TView.bottomAnchor.constraint(equalTo: TViewWrapper.bottomAnchor).isActive = true
        TView.leadingAnchor.constraint(equalTo: TViewWrapper.leadingAnchor).isActive = true
        TView.trailingAnchor.constraint(equalTo: TViewWrapper.trailingAnchor).isActive = true
        //MARK: Setting TMapGpsManager.
        TGpsManager.delegate = self
        TGpsManager.openGps()
        
        //MARK: ContentTagButtons.
        TourTagStackView.spacing = 10.0
        TourTagStackView.axis = .horizontal
        TourTagStackView.distribution = .fillEqually
        TourTagStackView.alignment = .center
        
        self.BreweryDetailStackView.addArrangedSubview(TourTagStackView)
        TourTagStackView.translatesAutoresizingMaskIntoConstraints = false
        TourTagStackView.topAnchor.constraint(equalTo: TViewWrapper.bottomAnchor, constant: 10.0).isActive = true
        TourTagStackView.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
        TourTagStackView.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        TourTagStackView.bottomAnchor.constraint(equalTo: TourTagStackView.topAnchor, constant: 40.0).isActive = true
        
        TourTagStackView.addArrangedSubview(createButton(contentType.GwanGwang.rawValue))
        TourTagStackView.addArrangedSubview(createButton(contentType.MunHwa.rawValue))
        TourTagStackView.addArrangedSubview(createButton(contentType.HangSa.rawValue))
        
        TourTagStackView2.spacing = 10.0
        TourTagStackView2.axis = .horizontal
        TourTagStackView2.distribution = .fillEqually
        TourTagStackView2.alignment = .center
        
        self.BreweryDetailStackView.addArrangedSubview(TourTagStackView2)
        TourTagStackView2.translatesAutoresizingMaskIntoConstraints = false
        TourTagStackView2.topAnchor.constraint(equalTo: TourTagStackView.bottomAnchor, constant: 0.0).isActive = true
        TourTagStackView2.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor, constant: 10.0).isActive = true
        TourTagStackView2.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor, constant: -10.0).isActive = true
        TourTagStackView2.bottomAnchor.constraint(equalTo: TourTagStackView2.topAnchor, constant: 40.0).isActive = true
        
        TourTagStackView2.addArrangedSubview(createButton(contentType.SukBak.rawValue))
        TourTagStackView2.addArrangedSubview(createButton(contentType.Shopping.rawValue))
        TourTagStackView2.addArrangedSubview(createButton(contentType.Food.rawValue))
        
        //MARK: Setting Tour list.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        TourListCollectionView.collectionViewLayout = layout
        TourListCollectionView.collectionViewLayout.invalidateLayout()
        
        //AutoLayout
        self.BreweryDetailStackView.addArrangedSubview(TourListCollectionView)
        TourListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        TourListCollectionView.topAnchor.constraint(equalTo: TourTagStackView2.bottomAnchor, constant: 10.0).isActive = true
        TourListCollectionView.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor).isActive = true
        TourListCollectionView.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor).isActive = true
        TourListCollectionView.bottomAnchor.constraint(equalTo: TourListCollectionView.topAnchor, constant: 300.0).isActive = true

        TourListCollectionView.backgroundColor = .black
//        TourListCollectionView.layer.borderWidth = 2.0
//        TourListCollectionView.layer.borderColor = UIColor.init(named: "red")?.cgColor
        TourListCollectionView.register(TourCollectionViewCell.self, forCellWithReuseIdentifier: "TourCell")
        TourListCollectionView.delegate = self
        TourListCollectionView.dataSource = self
        TourListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        BreweryDetailStackView.addSubview(TourListCollectionView)
        TourListCollectionView.topAnchor.constraint(equalTo: TView.bottomAnchor, constant: 10.0).isActive = true
        TourListCollectionView.bottomAnchor.constraint(equalTo: BreweryDetailStackView.bottomAnchor, constant: -300.0).isActive = true
        TourListCollectionView.leadingAnchor.constraint(equalTo: BreweryDetailStackView.leadingAnchor).isActive = true
        TourListCollectionView.trailingAnchor.constraint(equalTo: BreweryDetailStackView.trailingAnchor).isActive = true

        print("BreweryDetailViewController did load, breweryName: \(BreweryName)")
//        setMapMarkerItem()
//        searchPOI("자산어보")
    }
    
    //MARK: Private functions.
//    private func addCircle(_ point: TMapPoint) {
//
//        let circle = TMapCircle()
//        MapCircles.append(circle)
//        circle.setCenter(point)
//        circle.setRadiusVisible(true)
//        circle.setCircleRadius(200)
//        circle.setCircleLineColor(UIColor.red.cgColor)
//        circle.setCircleLineWidth(2.0)
//        circle.setCircleAreaColor(UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2).cgColor)
//
//        TView.addCustomObject(circle, id: String(MapCircles.count))
//    }
    
    @objc private func tapButton(_ sender: UIButton) {
        
        switch sender.titleLabel!.text {
        case contentType.GwanGwang.rawValue:
            print("관광")
            changeContentTypeId(12)
        case contentType.MunHwa.rawValue:
            print("MunHwa")
            changeContentTypeId(14)
        case contentType.HangSa.rawValue:
            print("HangSa")
            changeContentTypeId(15)
        case contentType.SukBak.rawValue:
            print("SukBak")
            changeContentTypeId(32)
        case contentType.Shopping.rawValue:
            print("Shopping")
            changeContentTypeId(38)
        case contentType.Food.rawValue:
            print("Food")
            changeContentTypeId(39)
        default:
            print("?")
        }
    }
    private func changeContentTypeId(_ id: Int) {
        if ContentTypeId == id {
            ContentTypeId = nil
        } else {
            ContentTypeId = id
        }
    }
    private func removeTours() {
        content.tours = [tour?]()
    }
    
    private func searchPOI(_ keyword: String) -> Any {
        let result = TViewPathData.requestFindAllPOI(keyword)
        debugPrint(result)
        return result
    }
    private func createButton(_ title: String) -> UIButton {
        let Button: UIButton = UIButton()
        
        Button.setTitle(title, for: .normal)
        
        Button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        Button.backgroundColor = .gray
        
        Button.setTitleColor(UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5), for: .normal)
        
        Button.layer.borderWidth = 1.0
        Button.layer.borderColor = UIColor.black.cgColor
        Button.layer.cornerRadius = 10.0
        return Button
    }
    
    private func setDetailPageContent() {
        Server.getDetailPage(BreweryName, ContentTypeId: ContentTypeId) {dataJson in
            guard let b = dataJson["brewery"].dictionary else {
                debugPrint(dataJson)
                fatalError("Brewery data json ERROR")
            }
            Server.getImg(b["url_img"]!.string!) {img in
                let dp = brewery(name: b["name"]!.string, image: img, desc: b["desc"]!.string, homePageUrl: b["home_page"]!.string, mapX: b["location"]!.array![0].double, mapY: b["location"]!.array![1].double, applyUrl: b["url_apply"]!.string, price: b["price"]!.int, availableDay: b["available_day"]!.string)
                self.content.brewery = dp
                
                self.setBreweryMarkerItem(TMapPoint(lon: self.content.brewery!.mapX!, lat: self.content.brewery!.mapY!))
                self.DetailTextBox.text = self.content.brewery!.desc
                self.BreweryImageView.image = self.content.brewery!.image
            }
            guard let tours = dataJson["content"].array else {
                fatalError("tour data json ERROR")
            }
            
            for i in tours {
                let each = i.dictionary!
                Server.getImg(each["firstimage"]!.string!) {img in
                    debugPrint(each)
                    let t = tour(image: img ?? UIImage(named: "logo"), contentType: each["contenttypeid"]!.int, dist: each["dist"]!.int, title: each["title"]!.string, contentId: each["contentid"]!.int, mapX: each["mapx"]!.double, mapY: each["mapy"]!.double)
                    
                    self.content.tours.append(t)
                    self.TourListCollectionView.reloadData()
                }
            }
        }
    }
    
    private func setBreweryMarkerItem(_ point: TMapPoint) {
        print("setMapMarkerItem")
        print("point: \(point)")
        TView.setCenter(point)
//        let TMarkerItem = TMapMarkerItem(
        let TMarkerItem = TMapMarkerItem2()
        TMapMarkerItem.setIcon(UIImage(named: "TrackingDot"), anchorPoint: CGPoint(x: 0.5, y: 0.5))
        TMapMarkerItem.setTMapPoint(point)
        TMapMarkerItem.setVisible(true)
        TView.addTMapMarkerItemID("BreweryMarker", markerItem2: TMarkerItem)
    }
    private func setTourMarketItem(_ tourCellVisible: TourCollectionViewCell) {
        let markerImage = UIImage(named: "TrackingDotHalo")
        debugPrint("set Tour Market Item 1 with \(tourCellVisible)")
        
        
        let point = TMapPoint(lon: self.content.tours[tourCellVisible.TourId]!.mapX!, lat: self.content.tours[tourCellVisible.TourId]!.mapY!)
        self.TViewCurrentTourCell.setIcon(markerImage)
        self.TViewCurrentTourCell.setTMapPoint(point)
        self.TViewCurrentTourCell.setVisible(true)
        self.TViewCurrentTourCell.setName(tourCellVisible.TourName)
    }
    
//    private func setTourMarkerItems(_ ) {
//
//        TourMarkerItems.removeAll()
//        print("marker removed")
//
//        let markerImage = UIImage(named: "TrackingDotHalo")
//        for i in 0...tourCells.count {
//            print("\(i)th tour marker creating...")
//            debugPrint(tourCells)
//            guard let temp = tourCells[i] as? TourCollectionViewCell else {
//                fatalError("creating Marker Item with tourCell failed")
//            }
//            debugPrint(temp)
//
//            let TourMarkerItem = TMapMarkerItem2()
//            TourMarkerItems.append(TourMarkerItem)
//            TourMarkerItem.setIcon(markerImage)
//            TourMarkerItem.setTMapPoint(TMapPoint(lon: self.content.tours[temp.TourId]!.mapX!, lat: self.content.tours[temp.TourId]!.mapY!))
//            TourMarkerItem.setName(self.content.tours[temp.TourId]!.title)
//            TourMarkerItem.setVisible(true)
//            print("Marker Item \(TourMarkerItem.getName()) added")
//            TView.addTMapMarkerItemID(String(TourMarkerItems.count), markerItem2: TourMarkerItem)
//        }
//    }
//
}
extension BreweryDetailViewController: TMapViewDelegate, TMapGpsManagerDelegate {

    //MARK: TMapViewDelegate
    func locationChanged(_ newTmp: TMapPoint!) {
        curTmp = newTmp
        
        print("location Changed - \(newTmp)")
    }

    func headingChanged(_ heading: Double) {
        print("heading Changed - \(heading)")
    }
    func sktMapApikeySucceed() {
        print("sktMapApikeySucceed")
    }
    func sktMapApikeyFailed(_ error: Error!) {
        print("sktMapApikeyFailed")
    }

    //MARK: TMapGpsManagerDelegate
    
}

extension BreweryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collection cell number: \(self.content.tours.count)")
        return self.content.tours.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.TourListCollectionView.dequeueReusableCell(withReuseIdentifier: "TourCell", for: indexPath) as? TourCollectionViewCell else {
            fatalError("TourCollectionViewCell Error")
        }
        cell.TourImage = self.content.tours[indexPath.row]!.image
        cell.backgroundColor = .white
        cell.TourName = self.content.tours[indexPath.row]!.title
        cell.TourDist = self.content.tours[indexPath.row]!.dist
        cell.TourContentType = self.content.tours[indexPath.row]!.contentType
        cell.TourId = indexPath.row
        
        TourListViewVisibleCell = cell
        
        print("created collection view cell \(indexPath.row)")
        
        return cell
    }
}

extension BreweryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300.0, height: self.TourListCollectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}
