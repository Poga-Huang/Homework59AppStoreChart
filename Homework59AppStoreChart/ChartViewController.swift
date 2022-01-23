//
//  ChartViewController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import UIKit

class ChartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet var containerViews: [UIView]!
    
    @IBAction func selectCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            containerViews[1].isHidden = true
        case 1:
            containerViews[1].isHidden = false
        default:
            return
        }
    }

}
