//
//  KakaoTalkActivity.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 2019/09/25.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import Foundation

class KakaoTalkActivity: UIActivity {
    
    //MARK: Methods to Override.
    override var activityTitle: String? {
        // 사용자가 보는 텍스트
        return "공유하기"
    }
    override var activityType: UIActivity.ActivityType? {
        // Activity Identifier
        return ActivityType("KakaoTalkLinkActivity")
    }
    override var activityImage: UIImage? {
        return UIImage(named: "kakao")
    }
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        // canPerform 함수가 true를 리턴한다면, UIActivityViewController는 사용자에게 서비스를 보여줌
        return true  // TODO
    }
    override func prepare(withActivityItems activityItems: [Any]) {
        // 사용자가 서비스를 선택한다면, prepare 함수가 실행됨
        return // TODO
    }
    override func perform() {
        // 추가적인 입력이 필요없기 때문에 바로 실행
        return // TODO
    }
    
    //MARK: KakaoLink object.
    var title: String!
    var link: KMTLinkObject!
    var imageURL: URL!
    var desc: String?
    // 이미지의 크기는 200x200 이상이여야 함 & 2MB미만
    var imageWidth: Int?
    var imageHeight: Int?
    
    override init() {
        super.init()
    }
}
