//
//  TestViewController.swift
//  Mac-Tour
//
//  Created by minhyeok lee on 20/09/2019.
//  Copyright © 2019 minhyeok lee. All rights reserved.
//

import UIKit
import FlexiblePageControl

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        print("(")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("!")
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("@@@")
        let cell = self.Table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let image = UIImage(named: "logo")
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        cell.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor).isActive = true
        return cell
    }
    
    
    let pageControl = FlexiblePageControl()
    let cell = UITableViewCell()

    @IBOutlet weak var Table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        print("##")
        
        Table.delegate = self
        Table.dataSource = self
        
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
