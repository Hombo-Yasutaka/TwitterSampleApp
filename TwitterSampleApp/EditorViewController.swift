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

        self.navigationItem.hidesBackButton = true
        configureTweetButton()
        configureTextView()
    }

    @IBAction func tappedTweetButton(_ sender: UIButton) {
        if let text = textField.text, !text.isEmpty,
           let content = textView.text, !content.isEmpty {
            saveTweetData(name: textField.text, content: textView.text)
            if presentingViewController != nil {
                // モーダル遷移
                dismiss(animated: true, completion: nil)
            } else {
                // ナビゲーション遷移
                navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert(title: "項目が空です", message: "ユーザー名とツイート文を入力してください")
        }

    }

    @IBAction func tappedCancelButton(_ sender: UIButton) {
        if presentingViewController != nil {
            // モーダル遷移
            dismiss(animated: true, completion: nil)
        } else {
            // ナビゲーション遷移
            navigationController?.popViewController(animated: true)
        }

    }

    func configureTweetButton() {
        tweetButton.layer.cornerRadius = tweetButton.bounds.height / 2
    }

    func configureTextView() {
        if presentingViewController != nil {
            // モーダル遷移
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        } else {
            // ナビゲーション遷移
            textField.text = tweetDataModel.name
            textView.text = tweetDataModel.content
        }
        textView.delegate = self
    }

    func configureTweetData(with tweet: TweetDataModel) {
        self.tweetDataModel = tweet
    }

    func saveTweetData(name: String?, content: String?) {
        let realm = try! Realm()
        try! realm.write {
            tweetDataModel.name = name ?? ""
            tweetDataModel.content = content ?? ""
            realm.add(tweetDataModel)
        }
    }

    func showAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 140 {
            textView.text = String(textView.text.prefix(140))
            showAlert(title: "文字数制限オーバー", message: "ツイートは140文字以内にしてください")
        }
    }
}
