//
//  ShareViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 2019/09/25.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit

class ShareViewController: UIActivityViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
        debugPrint(activityItems)
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
