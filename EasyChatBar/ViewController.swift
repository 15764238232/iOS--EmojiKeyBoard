//
//  ViewController.swift
//  EasyChatBar
//
//  Created by DSY on 2017/7/14.
//  Copyright © 2017年 DSY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textFild: UITextField!
    @IBOutlet weak var btn: UIButton!

    var emojiKeyBoard = EmojiKeyBoard()

    @IBAction func click(_ sender: Any) {

        emojiKeyBoard.showEmojiKeyBoard(vc: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        emojiKeyBoard.initEmojiKeyBoard(keyBoradHeight: 200, textField: textFild)
        btn.setTitle("click", for: .normal)
        textFild.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        emojiKeyBoard.dissmissEmojiKeyBoard()
    }
}

