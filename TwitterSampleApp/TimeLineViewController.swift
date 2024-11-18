//
//  TimeLineViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/16.
//

import UIKit

class TimeLineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tweetDataList: [TweetDataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TimeLineViewControllerが表示されました")

        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 18.0, *) {
            tableView.fillerRowHeight = 50
        }
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setTweetData()
    }
    
    func setTweetData() {
        for i  in 1...5 {
            let tweetDataModel = TweetDataModel(
                name: "ユーザー\(i)",
                content: "ツイート\(i)"
            )
            tweetDataList.append(tweetDataModel)
            
        }
    }
}

extension TimeLineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let tweetDataModel: TweetDataModel = tweetDataList[indexPath.row]
        cell.textLabel?.text = tweetDataModel.name
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.text = tweetDataModel.content
        return cell
    }
}
