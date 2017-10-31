//
//  HistoryViewController.swift
//  simple-calc-ios2
//
//  Created by Kelley Lu Chen on 10/30/17.
//  Copyright © 2017 Kelley Lu Chen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var history = [String]()
    
    @IBOutlet weak var display: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for equation in history {
            let label = UILabel(frame: CGRect(x: 10, y: 20 + history.index(of: equation)! * 40, width: 500, height: 100))
            label.textColor = UIColor.purple
            label.text = equation
            self.view.addSubview(label)
        }
    }
}
