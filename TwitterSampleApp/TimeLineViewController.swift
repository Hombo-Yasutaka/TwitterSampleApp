//
//  TimeLineViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/16.
//

import UIKit
import RealmSwift

class TimeLineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!

    var tweetDataList: [TweetDataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TimeLineViewControllerが表示されました")

        configureButton()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTweetData()
        tableView.reloadData()
    }

    @IBAction func tappedAddButton(_ sender: UIButton) {
        print("EditViewControllerへ遷移します")
        navigateToEditViewController()
    }

    func setTweetData() {
        let realm = try! Realm()
        let result = realm.objects(TweetDataModel.self)
        tweetDataList = Array(result)
    }

    func configureButton() {
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }

    func configureTableView() {
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 18.0, *) {
            tableView.fillerRowHeight = 50
        }

        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "TimeLineTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TimeLineCellID")
    }

    func navigateToEditViewController() {
        let storyboard = UIStoryboard(name: "EditorViewController", bundle: nil)
        guard let nextVC = storyboard.instantiateInitialViewController() as? EditorViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}

extension TimeLineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCellID", for: indexPath)as! TimeLineTableViewCell
        let tweetDataModel: TweetDataModel = tweetDataList[indexPath.row]
        cell.setup(userName: tweetDataModel.name, detail: tweetDataModel.content)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetTweet = tweetDataList[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(targetTweet)
        }
        tweetDataList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
