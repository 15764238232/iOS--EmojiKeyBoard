//
//  EmojiKeyBoard.swift
//  EasyChatBar
//
//  Created by DSY on 2017/7/14.
//  Copyright © 2017年 DSY. All rights reserved.
//  自定义的表情键盘

import Foundation
import UIKit

class EmojiKeyBoard:UIView{

   fileprivate var collectionView1 :UICollectionView?
   fileprivate var collectionView2 :UICollectionView?
   fileprivate var collectionView3 :UICollectionView?
   fileprivate var scrollView:UIScrollView?
   fileprivate var screenWidth = UIScreen.main.bounds.width
   fileprivate var screenHeight = UIScreen.main.bounds.height
   fileprivate var pageControl = UIPageControl()
   fileprivate var sendButton = UIButton()
   fileprivate let sendBarHeight:CGFloat = 30
   fileprivate var viewFlag = false
   fileprivate var myTextField :UITextField?

   fileprivate var emojis1 = ["😄","😂","😆",
                  "😊","😌","😍",
                  "😘","😚","😝",
                  "🤗","😎","🤡",
                  "😔","😣","🙁",
                  "😫","😤","😡",
                  "😳","😱","😭",
                  "😪","😷","✕"]

   fileprivate var emojis2 = ["👻","💀","👿",
                   "👍","👎","👊",
                   "✊","✌️","🤘",
                   "👌","🤙","💪",
                   "💋","👄","🔥",
                   "🔑","🎸","🏀",
                   "🎱","🤺","🎧",
                   "🎲","🏅","✕"]

   fileprivate var emojis3 = ["🐶","🐰","🐼",
                   "🐯","🐷","🐸",
                   "🙈","🙉","🐔",
                   "🐥","🦉","🐗",
                   "🐝","🐞","🐴",
                   "🌹","🌺","🌵",
                   "🍀","💐","🌼",
                   "🌻","🌴","✕"]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //开放的方法,初始化控件
    func initEmojiKeyBoard(keyBoradHeight:CGFloat,textField:UITextField){

        myTextField = textField

        self.frame = CGRect.init(x: 0, y: screenHeight - keyBoradHeight, width: screenWidth, height: keyBoradHeight)
        initScrollView(keyBoardHeight: keyBoradHeight)
        initCollectView(keyBoardHeight: keyBoradHeight)

        scrollView?.addSubview(collectionView1!)
        scrollView?.addSubview(collectionView2!)
        scrollView?.addSubview(collectionView3!)
    }

    //开放的方法,弹出表情键盘
    func showEmojiKeyBoard(vc:UIViewController){
        if !viewFlag{
            vc.view.addSubview(self)
            viewFlag = true
        }
    }

    //开放的方法,关闭表情键盘
    func dissmissEmojiKeyBoard(){
        if viewFlag{
            self.removeFromSuperview()
            viewFlag = false
        }
    }

    func getSendMessageButton() -> UIButton{

        return sendButton
    }

    //初始化collectview
  fileprivate  func initCollectView(keyBoardHeight:CGFloat){

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: screenWidth/8, height: (keyBoardHeight - sendBarHeight)/3)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView1 = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)), collectionViewLayout: flowLayout)

        collectionView2 = UICollectionView.init(frame: CGRect.init(x: screenWidth, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)), collectionViewLayout: flowLayout)

        collectionView3 = UICollectionView.init(frame: CGRect.init(x: screenWidth * 2, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)), collectionViewLayout: flowLayout)

        collectionView1?.tag = 1
        collectionView2?.tag = 2
        collectionView3?.tag = 3

        collectionView1?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView2?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView3?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        collectionView1?.delegate = self
        collectionView2?.delegate = self
        collectionView3?.delegate = self

        collectionView1?.dataSource = self
        collectionView2?.dataSource = self
        collectionView3?.dataSource = self

        collectionView1?.register(UINib.init(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCollectionViewCell")
        collectionView2?.register(UINib.init(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCollectionViewCell")

        collectionView3?.register(UINib.init(nibName: "EmojiCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCollectionViewCell")

    }

    //初始化ScrollView
   fileprivate func initScrollView(keyBoardHeight:CGFloat){

        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: (keyBoardHeight - sendBarHeight)))
        scrollView?.contentSize = CGSize.init(width: screenWidth * 3, height: (keyBoardHeight - sendBarHeight))
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = true

        initPageControlAndSendButton(keyBoradHeight: keyBoardHeight)

        scrollView?.delegate = self
        self.addSubview(scrollView!)
    }

   //初始化tPageControl 和 SendButton
   fileprivate func initPageControlAndSendButton(keyBoradHeight:CGFloat){

        let uiPageControlSize = pageControl.size(forNumberOfPages: 3)

        pageControl.frame = CGRect.init(x: screenWidth / 2 - uiPageControlSize.width / 2, y: keyBoradHeight - sendBarHeight + (sendBarHeight / 2 - uiPageControlSize.height / 2 ) , width: uiPageControlSize.width, height: uiPageControlSize.height)

        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pageControl.currentPage = 0
        self.addSubview(pageControl)

        let uiSendButtonSize = CGSize.init(width: 40, height: 25)
        sendButton.frame =  CGRect.init(x: screenWidth - uiSendButtonSize.width-10, y: keyBoradHeight - sendBarHeight + (sendBarHeight / 2 - uiSendButtonSize.height / 2 ) , width: uiSendButtonSize.width, height: uiSendButtonSize.height)
        sendButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        sendButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        sendButton.layer.cornerRadius = 4
        sendButton.setTitle("发送", for: .normal)
        self.addSubview(sendButton)
    }
}

extension EmojiKeyBoard :UICollectionViewDelegate,UICollectionViewDataSource{

    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis1.count
    }

    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCollectionViewCell", for: indexPath as IndexPath) as! EmojiCollectionViewCell

        switch collectionView.tag {
        case 1:
            cell.emojilabel.text = emojis1[indexPath.row]
            break
        case 2:
            cell.emojilabel.text = emojis2[indexPath.row]
            break
        case 3:
            cell.emojilabel.text = emojis3[indexPath.row]
            break
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if(indexPath.row == emojis1.count - 1){

            if(!(myTextField?.text?.isEmpty)!){

                var strNow   = myTextField?.text
                let index = strNow?.index(strNow!.startIndex, offsetBy: (strNow?.characters.count)! - 1)
                let strNew = strNow?.substring(to: index!)
                myTextField?.text = strNew
            }

        }else{

            switch collectionView.tag {
            case 1:
                myTextField?.text?.append(emojis1[indexPath.row])
                break
            case 2:
                myTextField?.text?.append(emojis2[indexPath.row])
                break
            case 3:
                myTextField?.text?.append(emojis3[indexPath.row])
                break
            default:
                break
            }
        }


    }
}

extension EmojiKeyBoard :UIScrollViewDelegate{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollviewW =  scrollView.frame.size.width;
        let x = scrollView.contentOffset.x;
        let page = (x + scrollviewW / 2) /  scrollviewW;
        pageControl.currentPage = Int(page)
    }
}

