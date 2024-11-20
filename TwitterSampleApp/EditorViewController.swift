//
//  EditorViewController.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/20.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTweetButton()
    }


    @IBAction func tappedCancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func configureTweetButton() {
        tweetButton.layer.cornerRadius = tweetButton.bounds.height / 2
    }
}
