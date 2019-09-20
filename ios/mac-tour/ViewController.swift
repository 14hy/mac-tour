//
//  ViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 11/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    //MARK: 메인페이지 데이터 캡슐화
    struct banner {
        var title: String!
        var image: UIImage!
    }
    
    struct brewery {
        var name: String!
        var region: String!
        var image: UIImage!
    }
    
    struct MainPage {
        var banners = [banner?]()
        var breweries = [brewery?]()
    }

    
    //MARK: Properties.
    @IBOutlet weak var MainNavigationItem: UINavigationItem!
    @IBOutlet weak var TagBarButton: UIBarButtonItem!
    @IBOutlet weak var MainPageTableView: UITableView!
    @IBOutlet var BannerLeftSwipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var BannerRightSwipeGesture: UISwipeGestureRecognizer!
    let MainPageActivityIndicatorView = UIActivityIndicatorView()
    
    var currentBreweryName: String?
    var numberOfBannerPage = 3 // 배너의 총 수
    var currentBannerPage = 0 // 현재 배너의 페이지
    // 배너 페이지 인덱스 조작.
    func increasePage() {
        currentBannerPage += 1
        if currentBannerPage >= numberOfBannerPage {
            currentBannerPage = 0
        }
    }
    func decreasePage() {
        currentBannerPage -= 1
        if currentBannerPage < 0 {
            currentBannerPage = numberOfBannerPage - 1
        }
    }
    
    
    //MARK: Actions.
    @IBAction func BannerLeftSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        increasePage()
        print("BannerSwipeGesture - left - \(currentBannerPage)")
    }
    @IBAction func BannerRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        decreasePage()
        print("BannerSwipeGesture - right - \(currentBannerPage)")
    }
    @IBAction func TagBarButtonAction(_ sender: UITapGestureRecognizer) {
        print("TagBarButtonAction - \(TagBarButtonTitle!)")
    }
    
    
    //MARK: Segue Func.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BreweryDetail" {
            print("BreweryDetail")
            let dest = segue.destination as! BreweryDetailViewController
            dest.BreweryName = self.currentBreweryName!
            
        }
        if segue.identifier == "BannerDetail" {
            print("BannerDetail")
//            let dest = segue.destination as! BannerDetailViewController
        }
    }
    
    //MARK: Assets.
    let logoImage = UIImage(named: "logo")
    var content: MainPage = MainPage()
    
    
    //Setting TagBarButton.
    var TagBarButtonTitle: String? = "지역선택"
    var ComputedTagBarButtonTitle: String? {
        set {
            TagBarButtonTitle = newValue
        }
        get {
            return TagBarButtonTitle
        }
    }
    
    //MARK: 메인페이지 데이터 세팅.
    private func setAssets(_ data: JSON) -> Void {
        
        print(data)
        guard let banners = JSON(data)["banners"].array,
            let breweries = JSON(data)["breweries"].array else {
                fatalError("error in json key value")
        }
        
        // 데이터를 넣는 부분
        for each in banners {
            Server.getImg(each["url_imgs"].array![0].string!) { imgView in
                let temp: banner = banner(title: each["title"].string, image: imgView)
                self.content.banners.append(temp)
                print("banner set")
                self.MainPageTableView.reloadData()
            }
        }
        for each in breweries {
            Server.getImg(each["url_img"].string!) { imgView in
                let temp: brewery = brewery(name: each["name"].string, region: each["region"].string, image: imgView)
                self.content.breweries.append(temp)
                print("brewery set")
                self.MainPageTableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainPageActivityIndicatorView.hidesWhenStopped = true
        MainPageActivityIndicatorView.style = .whiteLarge
        MainPageActivityIndicatorView.color = .white
        
        self.view.addSubview(MainPageActivityIndicatorView)
        MainPageActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        MainPageActivityIndicatorView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        MainPageActivityIndicatorView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        MainPageActivityIndicatorView.startAnimating()
        
        //MARK: 데이터 요청.
        Server.getMainPage("경기", activityIndicator: MainPageActivityIndicatorView, completion: setAssets(_:))
        
        // Navigation Bar에 맥투 로고를 띄웁니다.
        let titleImageView = UIImageView(image: logoImage)
        titleImageView.contentMode = .scaleAspectFit
        MainNavigationItem.titleView = titleImageView
        
        // Navigation Bar에 태그 선택을 위한 버튼을 띄웁니다.
        // TODO: 태그 선택기능.
        if let ComputedTagBarButtonTitle = ComputedTagBarButtonTitle {
            TagBarButton.title = ComputedTagBarButtonTitle
        }
        
        // TableView delegate 및 dataSource 설정.
        MainPageTableView.delegate = self
        MainPageTableView.dataSource = self
        // MainPageTableView 높이 설정.
        MainPageTableView.rowHeight = 200.0
        
        // 배너이미지에 Swipe gesture 방향 설정.
        BannerRightSwipeGesture.direction = .right
        BannerLeftSwipeGesture.direction = .left
        
        MainPageActivityIndicatorView.stopAnimating()
    }
}

//MARK: TableView Protocols.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of row? \(content.banners.count + content.breweries.count)")
        if content.banners.count > 0 {
            return 2 * (1 + content.breweries.count) - 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            // 배너 TableViewCell 생성하기.
            print("table View \(row) created")
            // Generate Banner Cell.
            print("row at 0")
            guard let cell: BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell") as? BannerTableViewCell else {
                fatalError("BannerTableViewCell ERROR")
            }
            if self.content.banners.count > 0 {
                // 인덱스 참조에러.
                cell.BannerImageView.image = self.content.banners[currentBannerPage]?.image
            }
            return cell
        } else if row % 2 != 0 {
            guard let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") else {
                fatalError("Empty Cell ERROR")
            }
            return cell
        } else {
            // 브루어리 TableViewCell 생성하기.
            print("table View \(row) created")
            guard let cell: BreweryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell") as? BreweryTableViewCell else {
                fatalError("BannerTableViewCell ERROR")
            }
            
            // Set Brewery Image.
            cell.BreweryImageView.image = self.content.breweries[row / 2 - 1]?.image
            cell.layoutMargins = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            cell.BreweryName = self.content.breweries[row / 2 - 1]?.name
            cell.BreweryRegionTag.text = self.content.breweries[row / 2 - 1]?.region
//            let selectedBackView = UIView()
//            selectedBackView.backgroundColor = .red
//            cell.selectedBackgroundView = selectedBackView
            
            return cell
        }
    }
    // 배너 혹은 브루어리 상세페이지 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        print("테이블 클릭: \(row)")
        if row == 0 {
            // 배너 페이지 세그웨이
            performSegue(withIdentifier: "BannerDetail", sender: nil)
        } else if row % 2 != 0 {
            return
        }
        else {
            // 브루어리 상세 페이지 세그웨이
            currentBreweryName = content.breweries[row/2 - 1]?.name
            performSegue(withIdentifier: "BreweryDetail", sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            return 10.0
        }
        else {
            return 200.0
        }
    }
    
}
