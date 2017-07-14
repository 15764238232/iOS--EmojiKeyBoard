# iOS--EmojiKeyBoard
用swift3实现的自定义的表情键盘(适配5s的屏幕大小)

使用方法:
#1.首先定义全局变量,初始化它 
 var emojiKeyBoard = EmojiKeyBoard()
 emojiKeyBoard.initEmojiKeyBoard(keyBoradHeight: 200, textField: textFild) //高度传入软键盘的高度
#2.调用展示和消失方法
  emojiKeyBoard.showEmojiKeyBoard(vc: self)
  emojiKeyBoard.dissmissEmojiKeyBoard()
#  如图:
  
![img](https://github.com/15764238232/iOS--EmojiKeyBoard/blob/master/EasyChatBar/screenShots/IMG_1787.PNG)
