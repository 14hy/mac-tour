//
//  utils.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 2019/09/23.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import Foundation

func resizeImage(image: UIImage, newSize: CGFloat) -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: newSize, height: newSize))
    image.draw(in: CGRect(x: 0, y: 0, width: newSize, height: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

