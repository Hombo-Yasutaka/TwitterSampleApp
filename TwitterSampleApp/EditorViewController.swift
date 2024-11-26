//
//  EditorViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/20.
//

import UIKit
import RealmSwift

class EditorViewController: UIViewController {

    private let placeholderText = "いまどうしてる？"

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    var tweetDataModel = TweetDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTweetButton()
        configureTextView()
    }

    @IBAction func tappedTweetButton(_ sender: UIButton) {
        saveTweetData(name: textField.text, content: textView.text)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func configureTweetButton() {
        tweetButton.layer.cornerRadius = tweetButton.bounds.height / 2
    }

    func configureTextView() {
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray

        textView.delegate = self
    }

    func saveTweetData(name: String?, content: String?) {
        let realm = try! Realm()
        try! realm.write {
            tweetDataModel.name = name ?? "未入力ユーザー"
            tweetDataModel.content = content ?? "未入力ツイート"
            realm.add(tweetDataModel)
        }
        print("name: \(tweetDataModel.name), content: \(tweetDataModel.content)")
    }
}

extension EditorViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText && textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}
