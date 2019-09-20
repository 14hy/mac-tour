//
//  Server.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 13/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Server {
    struct detailPageParameters: Encodable {
        let BreweryName: String!
        let ContentTypeId: Int?
    }
    struct mainPageParameters: Encodable {
        let region: String!
    }
    
    static func getMainPage(_ region: String?, activityIndicator: UIActivityIndicatorView, serverUrl: String="https://mac-tour-dot-mac-tour-251517.appspot.com",
                            completion: @escaping (JSON) -> Void) {
        // MainPage 데이터 받아오고 escaping closure 함수 실행.
        let parameters = mainPageParameters(region: region)
        AF.request("\(serverUrl)/main-page/", method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil).validate().responseJSON {response in
            if (try? response.result.get()) != nil {
                guard let data = response.data else {
                    fatalError("error in response data")
                }
                let dataJson = JSON(data)
                completion(dataJson)
                
            }
        }
    }
    static func getImg(_ url: String, completion: @escaping (UIImage?) -> Void) {
        // 이미지 주소 URL을 받아 다운로드 받고, escaping closure 함수 실행.
        AF.download(url).responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
                completion(image)
            } else {
                fatalError("Error in getting image")
            }
        }
    }
    static func getDetailPage(_ breweryName: String!, ContentTypeId: Int?, serverUrl: String="https://mac-tour-dot-mac-tour-251517.appspot.com/", completion: @escaping (JSON) -> Void) {
        // 브루어리 이름을 받아 다운로드 받고, escaping closure 함수 실행.
        
        let parameters = detailPageParameters(BreweryName: breweryName, ContentTypeId: ContentTypeId ?? 0)
        
        AF.request("\(serverUrl)/detail-page/", method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil).response { response in
            guard let data = response.data else {
                fatalError("Error in get detailPage")
            }
            let dataJson = JSON(data)
            completion(dataJson)
        }
    }
}

