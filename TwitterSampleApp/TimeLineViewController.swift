//
//  TimeLineViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/16.
//

import UIKit

class TimeLineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TimeLineViewControllerが表示されました")

        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 18.0, *) {
            tableView.fillerRowHeight = 50
        }
    }
}
