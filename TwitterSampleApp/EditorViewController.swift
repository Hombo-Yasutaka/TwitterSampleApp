//
//  EditorViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/20.
//

import UIKit

class EditorViewController: UIViewController {

    private let placeholderText = "いまどうしてる？"

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTweetButton()
        configureTextView()
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
